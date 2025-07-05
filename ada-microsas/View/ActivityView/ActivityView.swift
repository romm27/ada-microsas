//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI
//gemini: Import UserNotifications to schedule notifications.
import UserNotifications

enum StateActivity{
    case treino
    case aquecimento
    case descanso
}

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var test = false
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var showCompletionAlert: Bool = false
    
    //gemini: The old counter is no longer needed as the new state machine below is more robust.
//    @State var contador: Int = 0
    
    //Deep Seek: We'll keep the original state enum but use it differently with the new data model
    @State var state: StateActivity = .aquecimento
    
    //Deep Seek: New state variables to work with ActivityPhase directly
    @State private var currentPhase: ActivityPhase?
    @State private var nextPhase: ActivityPhase?
    @State private var currentPhaseIndex: Int = 0
    @State private var currentRepetition: Int = 1

    var body: some View {
        NavigationStack{
            //gemini: The logic is now handled by the 'isResting' state, making the flow automatic and self-contained.
            Group {
                if let phase = currentPhase, phase.isRest {
                    //Deep Seek: Modified rest view to use ActivityPhase properties directly
                    VStack(spacing: 35){
                        Image(phase.imageAsset)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        VStack(spacing: 10){
                            Text(phase.name)
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)

                            Text("\(timerViewModel.getFormattedCurrentTimer())")
                                .font(.system(size: 58))
                                .fontWeight(.regular)
                                .foregroundStyle(.verdeLima)
                            
                            if let next = nextPhase {
                                VStack(spacing: 5){
                                    Text("Próxima Atividade")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    Text(next.name)
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack{
                        if let phase = currentPhase {
                            //Deep Seek: Unified activity view using ActivityPhase properties
                            ZStack{
                                Image(phase.isRest ? "BackgroundDescanso" :
                                      state == .treino ? "BackgroundTreino" : "BackgroundAquecimento")
                                
                                VStack(spacing: 5){
                                    Image(phase.imageAsset)
                                        .padding(8)
                                    Text(state == .treino ? "Treino" : "Aquecendo")
                                        .font(.callout)
                                        .fontWeight(.regular)
                                    Text(phase.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 48)
                            }
                        }
                        
                        Spacer()
                        
                        ProgressBarView()
                            .frame(width: 300, height: 300)
                        
                        Spacer()
                        
                        TotalProgressBarView()
                        
                        Spacer()
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismiss()
//                        planViewModel.setLevel(0)
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .padding()
                        }
                        .font(.headline)
                        .foregroundStyle(.quasePreto)
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
            .ignoresSafeArea(.all)
            .onAppear{
                print(" USER LEVEL: \(planViewModel.userLevel)")
                //Deep Seek: Modified to use the new data model initialization
                startFirstActivity()
            }
            
            //gemini: When any timer finishes, the state machine will determine the next step.
            .onChange(of: timerViewModel.isFinished) { isFinished in
                if isFinished {
                    proceedToNextPhase()
                }
            }
        }
    }
    
    //Deep Seek: Modified to work with ActivityPhase directly while keeping similar structure
    func startFirstActivity() {
        guard planViewModel.userLevel < DataTrainingModel.shared.trainingPlans.count else {
            dismiss()
            return
        }
        
        let workout = DataTrainingModel.shared.trainingPlans[planViewModel.userLevel]
        guard !workout.phases.isEmpty else {
            dismiss()
            return
        }
        
        currentPhase = workout.phases[0]
        state = currentPhase?.isRest == true ? .descanso : .aquecimento
        
        //Deep Seek: Set next phase if available
        if workout.phases.count > 1 {
            nextPhase = workout.phases[1]
        }
        
        timerViewModel.setTimerConfig(seconds: currentPhase?.duration ?? 0)
        timerViewModel.startTimer()
    }
    
    //gemini: This function schedules a local notification with a custom sound.
    func scheduleNotification(title: String, body: String, duration: TimeInterval, soundName: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        //gemini: The sound file must be in your project bundle.
        content.sound = UNNotificationSound(named: UNNotificationSoundName(soundName))

        // Trigger the notification after the specified duration
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    //Deep Seek: Modified version of passNextIntervalTraining that works with ActivityPhase
    func proceedToNextPhase() {
        guard planViewModel.userLevel < DataTrainingModel.shared.trainingPlans.count else {
            dismiss()
            return
        }
        
        let workout = DataTrainingModel.shared.trainingPlans[planViewModel.userLevel]
        
        // Check if there are more phases
        if currentPhaseIndex < workout.phases.count - 1 {
            currentPhaseIndex += 1
        } else {
            // Check if there are more repetitions
            if currentRepetition < workout.totalRepetitions {
                currentPhaseIndex = 0
                currentRepetition += 1
            } else {
                // Workout complete
                planViewModel.userLevel += 1
                dismiss()
                return
            }
        }
        
        // Update current and next phases
        currentPhase = workout.phases[currentPhaseIndex]
        
        // Update state based on activity type
        if currentPhase?.isRest == true {
            state = .descanso
        } else {
            state = currentRepetition > 1 ? .treino : .aquecimento
        }
        
        // Set next phase if available
        let nextIndex = currentPhaseIndex + 1
        if nextIndex < workout.phases.count {
            nextPhase = workout.phases[nextIndex]
        } else if currentRepetition < workout.totalRepetitions {
            nextPhase = workout.phases[0]
        } else {
            nextPhase = nil
        }
        
        timerViewModel.setTimerConfig(seconds: currentPhase?.duration ?? 0)
        timerViewModel.startTimer()
        
        // Schedule notification for non-rest activities
        if let phase = currentPhase, !phase.isRest {
            scheduleNotification(
                title: "Intervalo Concluído!",
                body: "Você completou: \(phase.name).",
                duration: TimeInterval(phase.duration),
                soundName: "finish_sound.caf"
            )
        }
    }
}

#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
