//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI
import UserNotifications

enum StateActivity {
    case treino
    case aquecimento
    case descanso
}

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State private var state: StateActivity = .aquecimento
    @State private var currentPhase: ActivityPhase?
    @State private var nextPhase: ActivityPhase?
    @State private var currentGroupIndex: Int = 0
    @State private var currentPhaseIndex: Int = 0
    @State private var currentRepetition: Int = 1
    @State private var currentGroupRepetition: Int = 1
    
    var body: some View {
        NavigationStack {
            Group {
                if let phase = currentPhase {
                    if phase.isRest {
                        // Rest View
                        RestPhaseView(
                            phase: phase,
                            nextPhase: nextPhase,
                            timerText: timerViewModel.getFormattedCurrentTimer()
                        )
                    } else {
                        // Activity View
                        ActivityPhaseView(
                            phase: phase,
                            state: state,
                            timerText: timerViewModel.getFormattedCurrentTimer()
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
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
            .onAppear {
                startWorkout()
            }
            .onChange(of: timerViewModel.isFinished) { isFinished in
                if isFinished {
                    proceedToNextPhase()
                }
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
        currentGroupRepetition = 1
        
        loadCurrentPhase()
    }
    
    private func proceedToNextPhase() {
        guard let workout = currentWorkout() else {
            dismiss()
            return
        }
        
        let currentGroup = workout.patternGroups[currentGroupIndex]
        
        // Move to next phase in current group
        if currentPhaseIndex < currentGroup.phases.count - 1 {
            currentPhaseIndex += 1
        } else {
            // Move to next repetition or next group
            if currentGroupRepetition < currentGroup.repetitions {
                currentPhaseIndex = 0
                currentGroupRepetition += 1
            } else {
                // Move to next group
                if currentGroupIndex < workout.patternGroups.count - 1 {
                    currentGroupIndex += 1
                    currentPhaseIndex = 0
                    currentGroupRepetition = 1
                } else {
                    // Workout complete
                    planViewModel.userLevel += 1
                    dismiss()
                    return
                }
            }
        }
        
        loadCurrentPhase()
    }
    
    private func loadCurrentPhase() {
        guard let workout = currentWorkout() else {
            dismiss()
            return
        }
        
        let currentGroup = workout.patternGroups[currentGroupIndex]
        currentPhase = currentGroup.phases[currentPhaseIndex]
        
        // Determine next phase
        if currentPhaseIndex < currentGroup.phases.count - 1 {
            nextPhase = currentGroup.phases[currentPhaseIndex + 1]
        } else if currentGroupRepetition < currentGroup.repetitions {
            nextPhase = currentGroup.phases.first
        } else if currentGroupIndex < workout.patternGroups.count - 1 {
            nextPhase = workout.patternGroups[currentGroupIndex + 1].phases.first
        } else {
            nextPhase = nil
        }
        
        // Update activity state
        state = currentPhase?.isRest == true ? .descanso :
                currentGroup.isWarmup ? .aquecimento : .treino
        
        // Start timer
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
}

// MARK: - Subviews

struct ActivityPhaseView: View {
    let phase: ActivityPhase
    let state: StateActivity
    let timerText: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(backgroundImageName)
                
                VStack(spacing: 5) {
                    Image(phase.imageAsset)
                        .padding(8)
                    Text(activityTypeText)
                        .font(.callout)
                        .fontWeight(.regular)
                    Text(phase.name)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 48)
            }
            
            Spacer()
            ProgressBarView()
                .frame(width: 300, height: 300)
            Spacer()
            TotalProgressBarView()
            Spacer()
        }
    }
    
    private var backgroundImageName: String {
        phase.isRest ? "BackgroundDescanso" :
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
    
    var body: some View {
        VStack(spacing: 35) {
            Image(phase.imageAsset)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            VStack(spacing: 10) {
                Text(phase.name)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text(timerText)
                    .font(.system(size: 58))
                    .fontWeight(.regular)
                    .foregroundStyle(.verdeLima)
                
                if let nextPhase = nextPhase {
                    VStack(spacing: 5) {
                        Text("Próxima Atividade")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        Text(nextPhase.name)
                            .font(.system(size: 13))
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
