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
    
    @State var state: StateActivity = .aquecimento
    
    //gemini: Add new state variables to manage the entire workout flow automatically.
    @State private var isResting: Bool = false
    @State private var isWarmup: Bool = true
    @State private var currentPhaseIndex: Int = 0
    @State private var currentRepetition: Int = 1
    @State private var currentActivityName: String = ""
    @State private var nextActivityName: String = ""
    
    var body: some View {
        NavigationStack{
            //gemini: The logic is now handled by the 'isResting' state, making the flow automatic and self-contained.
            Group {
                if isResting {
                    //gemini: A new, inline Rest UI that doesn't conflict with external views.
                    VStack(spacing: 35){
                        Image("BelezinhaDescanso")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        VStack(spacing: 10){
                            Text("Descansar")
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)

                            Text("\(timerViewModel.getFormattedCurrentTimer())")
                                .font(.system(size: 58))
                                .fontWeight(.regular)
                                .foregroundStyle(.verdeLima)
                            
                            VStack(spacing: 5){
                                Text("Próxima Atividade")
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                Text(nextActivityName)
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack{
                        switch state {
                        case .treino:
                            ZStack{
                                Image("BackgroundTreino")
                                
                                VStack(spacing: 5){
                                    Image("BelezinhaTreino")
                                        .padding(8)
                                    Text("Treino")
                                        .font(.callout)
                                        .fontWeight(.regular)
                                    //gemini: Display the current activity name dynamically.
                                    Text(currentActivityName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 48)
                            }
                        case .aquecimento:
                            ZStack{
                                Image("BackgroundAquecimento")
                                
                                VStack(spacing: 5){
                                    Image("BelezinhaAquecimento")
                                        .padding(8)
                                    Text("Aquecendo")
                                        .font(.callout)
                                        .fontWeight(.regular)
                                    //gemini: Display the current activity name dynamically.
                                    Text(currentActivityName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 48)
                            }
                        case .descanso:
                            //carla aqui :)
                            Text("carla")
                        }
                        
                        Spacer()
                        
                        ProgressBarView()
                            .frame(width: 300, height: 300)
                        
                        
                        
        //                    .alert("Parabéns!", isPresented: $timerViewModel.isFinished) {
        //                        Button("Ok") {
        //                            planViewModel.userLevel += 1
        //                            dismiss()
        //                        }
        //                    } message: {
        //                        Text("Você concluiu a atividade!")
        //                    }
                        
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
                //gemini: Start the first activity of the workout.
                startFirstActivity()
            }
            
            //gemini: When any timer finishes, the state machine will determine the next step.
            .onChange(of: timerViewModel.isFinished) { isFinished in
                if isFinished {
                    passNextIntervalTraining()
                }
            }
        }
    }
    
    //gemini: A helper function to start the very first activity.
    func startFirstActivity() {
        let training = DataTrainingModel.shared.trainingList[planViewModel.userLevel]
        isWarmup = true
        state = .aquecimento
        currentPhaseIndex = 0
        currentRepetition = 1
        currentActivityName = Warming.warmUp[0]
        let time = training.warmingUp.timeWarmUp[0]
        timerViewModel.setTimerConfig(seconds: time)
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
    
    //gemini: This state machine now controls the entire workout sequence.
    func passNextIntervalTraining() {
        let training = DataTrainingModel.shared.trainingList[planViewModel.userLevel]

        // --- Handle starting a new activity after a rest ---
        if isResting {
            isResting = false
            let time: Int
            if isWarmup {
                time = training.warmingUp.timeWarmUp[currentPhaseIndex]
                currentActivityName = Warming.warmUp[currentPhaseIndex]
                state = .aquecimento
            } else { // Main Training
                time = training.mainTraining.timeMainTraining[currentPhaseIndex]
                currentActivityName = MainTraining.mainTraining[currentPhaseIndex]
                state = .treino
                //gemini: Schedule the notification right before the main training timer starts.
                scheduleNotification(
                    title: "Intervalo Concluído!",
                    body: "Você completou: \(currentActivityName).",
                    duration: TimeInterval(time),
                    soundName: "finish_sound.caf" // IMPORTANT: Add your sound file to the project.
                )
            }
            timerViewModel.setTimerConfig(seconds: time)
            timerViewModel.startTimer()
            return
        }

        // --- Handle starting a rest period after an activity ---
        if isWarmup {
            let warmUpActivities = training.warmingUp.timeWarmUp
            // Check if there are more activities in the current warm-up set
            if currentPhaseIndex < warmUpActivities.count - 1 {
                isResting = true
                currentPhaseIndex += 1
                nextActivityName = Warming.warmUp[currentPhaseIndex]
                let restTime = training.warmingUp.warmUpRest[currentPhaseIndex - 1]
                timerViewModel.setTimerConfig(seconds: restTime)
                timerViewModel.startTimer()
            } else { // End of a warm-up set
                if currentRepetition < training.warmingUp.warmUpCount {
                    // More warm-up sets to go
                    isResting = true
                    currentRepetition += 1
                    currentPhaseIndex = 0
                    nextActivityName = Warming.warmUp[currentPhaseIndex]
                    let restTime = training.warmingUp.warmUpRest.last ?? 30 // Rest before next set
                    timerViewModel.setTimerConfig(seconds: restTime)
                    timerViewModel.startTimer()
                } else {
                    // Warm-up phase is complete, transition to main training
                    isWarmup = false
                    currentRepetition = 1
                    currentPhaseIndex = 0
                    isResting = true // Start with a rest before main training
                    nextActivityName = MainTraining.mainTraining[currentPhaseIndex]
                    let restTime = 60 // Default rest time before main training
                    timerViewModel.setTimerConfig(seconds: restTime)
                    timerViewModel.startTimer()
                }
            }
        } else { // Main Training Logic
            let mainActivities = training.mainTraining.timeMainTraining
            // Check if there are more activities in the current main training set
            if currentPhaseIndex < mainActivities.count - 1 {
                isResting = true
                currentPhaseIndex += 1
                nextActivityName = MainTraining.mainTraining[currentPhaseIndex]
                let restTime = 60 // Model does not specify main rest, using 60s default
                timerViewModel.setTimerConfig(seconds: restTime)
                timerViewModel.startTimer()
            } else { // End of a main training set
                if currentRepetition < training.mainTraining.mainTrainingCount {
                    // More main training sets to go
                    isResting = true
                    currentRepetition += 1
                    currentPhaseIndex = 0
                    nextActivityName = MainTraining.mainTraining[currentPhaseIndex]
                    let restTime = 60 // Default rest time
                    timerViewModel.setTimerConfig(seconds: restTime)
                    timerViewModel.startTimer()
                } else {
                    // Workout is complete!
                    planViewModel.userLevel += 1
                    dismiss()
                }
            }
        }
    }
}
#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}


// --- END OF FILE ---
