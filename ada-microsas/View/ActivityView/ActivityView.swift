//
//  ActivityView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI
import UserNotifications
import HealthKit

enum StateActivity {
    case treino
    case aquecimento
    case descanso
}

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    @EnvironmentObject var healthStore: HKHealthStore
    
    
    @State private var state: StateActivity = .aquecimento
    @State private var isResting: Bool = false
    @State private var currentGroupIndex: Int = 0
    @State private var currentPhaseIndex: Int = 0
    @State private var currentRepetition: Int = 1
    @State private var currentActivity: ActivityPhase?
    @State private var nextActivity: ActivityPhase?
    
    @State private var showCompletionAlert: Bool = false
    @State private var showAppleFitnessAlert: Bool = false
    @State private var couldPostOnAppleHealth: Bool = false
    
    @State var showAlert: Bool = false
    @State var showColapseView: Bool = false
    
    var body: some View {
        
        NavigationStack {
            Group {
                if let currentActivity = currentActivity {
                    if currentActivity.isRest {
                        RestPhaseView(
                            phase: currentActivity,
                            nextPhase: nextActivity,
                            timerText: timerViewModel.getFormattedCurrentTimer(),
                            onSkip: { // <--- AQUI: O QUE ACONTECE QUANDO "PULAR" É CLICADO
                                timerViewModel.endTimer() // Para o timer do descanso
                                proceedToNextPhase() // Avança para a próxima fase
                            }
                        )
                    } else {
                        ActivityPhaseView(
                            phase: currentActivity,
                            state: state,
                            timerText: timerViewModel.getFormattedCurrentTimer()
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                            Text("Sair")
                                .foregroundColor(.white)
                        }
                        .font(.system(size: 24, weight: .bold))
                    }
                    .alert("Cuidado!", isPresented: $showAlert) {
                        Button("Voltar", role: .cancel) {
                            //logica do tempo
                        }
                        NavigationLink(destination: TemporalColapseView()){
                            Button("Encerrar", role: .destructive) {
                                //timerViewModel.endTimer()
                                timerViewModel.pauseTimer()
                                timerViewModel.endTimer()
                                showColapseView.toggle()
                                //logica de encerrar
                            }
                        }
                    }
                    message: {
                        Text("Se você encerrar agora, vai perder todo o seu progresso. Tem certeza?")
                    }
                }
            }
            .preferredColorScheme(.dark)
            .ignoresSafeArea(.all)
            .onAppear {
                startWorkout()
            }
            .onChange(of: timerViewModel.isFinished) { isFinished in
                if isFinished {
                    proceedToNextPhase()
                }
            }
            .alert("Parabéns!", isPresented: $showCompletionAlert) {
                Button("OK") {
//                    dismiss()
                }
            } message: {
                Text("Você concluiu o treino com sucesso!")
            }
            .alert(couldPostOnAppleHealth ? "✅ Sucesso - Health " : "❌ Erro - Apple Health", isPresented: $showAppleFitnessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(couldPostOnAppleHealth ? "Sucesso ao sincronizar seu treino." :  "Erro ao sincronizar seu treino. \nHabilite permissões no app 'Health'." )
            }
        }
    }
    
    private func startWorkout() {
        guard let workout = currentWorkout() else {
            dismiss()
            return
        }
        
        currentGroupIndex = 0
        currentPhaseIndex = 0
        currentRepetition = 1
        
        loadCurrentPhase()
    }
    
    private func proceedToNextPhase() {
        guard let workout = currentWorkout() else {
            showCompletionAlert = true
            return
        }
        
        let currentGroup = workout.patternGroups[currentGroupIndex]
        
        if currentPhaseIndex < currentGroup.phases.count - 1 {
            currentPhaseIndex += 1
        } else if currentRepetition < currentGroup.repetitions {
            currentPhaseIndex = 0
            currentRepetition += 1
        } else if currentGroupIndex < workout.patternGroups.count - 1 {
            currentGroupIndex += 1
            currentPhaseIndex = 0
            currentRepetition = 1
        } else {
            // Workout complete
            planViewModel.userLevel += 1
            showCompletionAlert = true
            
            let activitySeconds = currentGroup.totalDuration
            Task{
                await saveRunningActivity(seconds: Double(activitySeconds)) //activity seconds
                showAppleFitnessAlert = true
            }
            
            return
        }
        
        loadCurrentPhase()
    }
    
    private func loadCurrentPhase() {
        guard let workout = currentWorkout() else {
            dismiss()
            return
        }
        
        let currentGroup = workout.patternGroups[currentGroupIndex]
        currentActivity = currentGroup.phases[currentPhaseIndex]
        
        // Set next activity if available
        let nextPhaseIndex = currentPhaseIndex + 1
        if nextPhaseIndex < currentGroup.phases.count {
            nextActivity = currentGroup.phases[nextPhaseIndex]
        } else if currentRepetition < currentGroup.repetitions {
            nextActivity = currentGroup.phases.first
        } else if currentGroupIndex < workout.patternGroups.count - 1 {
            nextActivity = workout.patternGroups[currentGroupIndex + 1].phases.first
        } else {
            nextActivity = nil
        }
        
        // Update activity state
        state = currentActivity?.isRest == true ? .descanso :
        currentGroup.isWarmup ? .aquecimento : .treino
        
        // Start timer
        timerViewModel.setTimerConfig(seconds: currentActivity?.duration ?? 0)
        timerViewModel.startTimer()
        
        // Schedule notification for non-rest activities
        if let currentActivity = currentActivity, !currentActivity.isRest {
            scheduleNotification(
                title: "Intervalo Concluído!",
                body: "Você completou: \(currentActivity.name).",
                duration: TimeInterval(currentActivity.duration),
                soundName: "finish_sound.caf"
            )
        }
    }
    
    private func currentWorkout() -> WorkoutPlan? {
        guard planViewModel.userLevel < DataTrainingModel.shared.trainingPlans.count else {
            return nil
        }
        return DataTrainingModel.shared.trainingPlans[planViewModel.userLevel]
    }
    
    private func scheduleNotification(title: String, body: String, duration: TimeInterval, soundName: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound(named: UNNotificationSoundName(soundName))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    //MARK: - SAVE > Running Activity
    func saveRunningActivity(seconds: Double) async {
        couldPostOnAppleHealth = false
        
        //Definir tipo da atividade
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        
        //Criar HKWorkoutBuilder
        let builder = HKWorkoutBuilder(healthStore: healthStore, configuration: configuration, device: .local())
        
        //Definir o inicio e o fim da atividade
        //TODO: Aqui trocamos a variável pelo tempo total da nossa atividade
        let startDate = Date().addingTimeInterval(-seconds)
        let endDate = Date() //Agora
        
        
        do {
            //Iniciar e terminar a colecao de dados para o builder
            try await builder.beginCollection(at: startDate)
            try await builder.endCollection(at: endDate)
            
            let workout = try await builder.finishWorkout()
            
            print("✅ SUCESSO! Treino de \(String(describing: workout?.workoutActivityType.name)).")
            couldPostOnAppleHealth = true
            
        } catch {
            print("❌ ERRO ao usar HKWorkoutBuilder: \(error.localizedDescription)")
            couldPostOnAppleHealth = false
        }
    }
}

extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .running: return "Corrida"
        default: return "Treino"
        }
    }
}

struct ActivityPhaseView: View {
    let phase: ActivityPhase
    let state: StateActivity
    let timerText: String
    
    var body: some View {
        
        ZStack {
            Image("RestImage")
                .resizable()
                .scaledToFill()
            VStack(spacing: 5) {
                Spacer()
                Image(phase.imageAsset)
                    .padding(8)
                Text(activityTypeText)
                    .font(.callout)
                    .fontWeight(.regular)
                Text(phase.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                    ProgressBarView()
                        .frame(width: 300, height: 300)
                Spacer()
                
                HStack(spacing: 12){
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        Text("Tempo")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.cinzaMuitoClaro)
                        //MARK: MUDAR O TEMPO AGUI
                        Text("00:21:30")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.brancoGelo)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        Text("Exercício")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.cinzaMuitoClaro)
                        //TODO: MUDAR O NIVEL AGUI
                        Text("1/5")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.brancoGelo)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        Text("Progresso")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.cinzaMuitoClaro)
                        //TODO: MUDAR O NIVEL AGUI
                        Text("17%")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.brancoGelo)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(.cinzaMedio)
                .cornerRadius(16)
                Spacer()
            }
            .padding(.horizontal, 32)
            
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
        
       
        
    }
    
    private var backgroundImageName: String {
        state == .treino ? "BackgroundTreino" : "BackgroundAquecimento"
    }
    
    private var activityTypeText: String {
        state == .treino ? "Treino" : "Aquecendo"
    }
}

struct RestPhaseView: View {
    let phase: ActivityPhase
    let nextPhase: ActivityPhase?
    let timerText: String
    let onSkip: () -> Void
    
    var body: some View {
        ZStack{
            
            Color.cinzaEscuro.edgesIgnoringSafeArea(.all)
            
            Image("RestImage")
                .resizable()
                .scaledToFill()
            
            VStack(spacing: 25) {
                
                if let nextPhase = nextPhase {
                    VStack(spacing: 5) {
                        Text("Próxima Atividade")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Text(nextPhase.name)
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }
                }
                
                Image(phase.imageAsset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                
                VStack(spacing: 25) {
                    Text(phase.name)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(timerText)
                        .font(.system(size: 35))
                        .fontWeight(.regular)
                        .foregroundStyle(.verdeLima)
                    
                    ButtonView()
                        .padding(.trailing, 12)
                    
                    Button("Pular") {
                        onSkip() // Dispara o callback para a ActivityView
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    
                    TotalProgressBarView()
                    

                }
            }
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    let phase = ActivityPhase(
        name: "Polichinelo",
        duration: 5,
        isRest: false,
        imageAsset: "BelezinhaAquecimento"
    )
    
    ActivityPhaseView(phase: phase, state: .treino, timerText: "00:05")
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
