//
//  RestView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct RestView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    @State private var currentCounter: Int = 0
    
    let currentIndex: Int
    
    private var workoutPlan: WorkoutPlan {
        DataTrainingModel.shared.trainingPlans[currentIndex]
    }
    
    private var currentGroup: PatternGroup {
        workoutPlan.patternGroups.first(where: { !$0.isWarmup }) ?? workoutPlan.patternGroups[0]
    }
    
    private var nextActivity: ActivityPhase? {
        let allPhases = currentGroup.phases.filter { !$0.isRest }
        guard currentCounter < allPhases.count - 1 else { return nil }
        return allPhases[currentCounter + 1]
    }
    
    private var totalActivitiesInGroup: Int {
        currentGroup.phases.filter { !$0.isRest }.count
    }

    var body: some View {

        ZStack{
            
            Image("RestImage")
                .resizable()
                .scaledToFill()
            
            VStack(spacing: 35) {
                Image("BelezinhaDescanso")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                VStack(spacing: 10) {
                    Text("Descansar")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("\(timerViewModel.getFormattedCurrentTimer())")
                        .font(.system(size: 58))
                        .fontWeight(.regular)
                        .foregroundStyle(.verdeLima)
                        .onAppear {
                            setupTimer()
                        }
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 5) {
                            HStack {
                                Text("Próxima Atividade")
                                Text("\(currentCounter + 1)/\(totalActivitiesInGroup)")
                                    .foregroundStyle(.verdeLima)
                            }
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            
                            if let nextActivity = nextActivity {
                                Text(nextActivity.name)
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
                            }
                            
                            Button("Proximo") {
                                currentCounter += 1
                                setupTimer()
                            }
                        }
                    }
                }
            }
            
        }
        .ignoresSafeArea(.all)


        .preferredColorScheme(.dark)
    }
    
    private func setupTimer() {
        timerViewModel.pauseTimer()
        timerViewModel.endTimer()
        
        let activePhases = currentGroup.phases.filter { !$0.isRest }
        guard currentCounter < activePhases.count else { return }
        
        let nextPhase = activePhases[currentCounter]
        timerViewModel.setTimerConfig(seconds: nextPhase.duration)
        timerViewModel.startTimer()
    }
}

#Preview {
    RestView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
