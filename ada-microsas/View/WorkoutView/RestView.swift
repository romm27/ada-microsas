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
    @State var contador: Int = 0
    let currentIndex: Int
    
    //Deep Seek: Computed property to get current workout plan
    private var workoutPlan: WorkoutPlan {
        guard currentIndex < DataTrainingModel.shared.trainingPlans.count else {
            return DataTrainingModel.shared.trainingPlans[0]
        }
        return DataTrainingModel.shared.trainingPlans[currentIndex]
    }
    
    //Deep Seek: Computed property to get next activity
    private var nextActivity: ActivityPhase? {
        let phases = workoutPlan.phases
        guard contador + 1 < phases.count else { return nil }
        return phases[contador + 1]
    }

    var body: some View {
        VStack(spacing: 35) {
            Image("BelezinhaDescanso")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            VStack(spacing: 10) {
                //titulo
                Text("Descansar")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                //timer
                Text("\(timerViewModel.getFormattedCurrentTimer())")
                    .font(.system(size: 58))
                    .fontWeight(.regular)
                    .foregroundStyle(.verdeLima)
                    .onAppear() {
                        timerViewModel.pauseTimer()
                        timerViewModel.endTimer()
                        //Deep Seek: Updated to use ActivityPhase duration
                        if !workoutPlan.phases.isEmpty {
                            timerViewModel.setTimerConfig(seconds: workoutPlan.phases[0].duration)
                            timerViewModel.startTimer()
                        }
                    }
                
                //proxima atividade
                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        HStack {
                            //titulo
                            Text("Próxima Atividade")
                            //contador fraçao
                            Text("\(contador + 1)/\(workoutPlan.phases.filter { !$0.isRest }.count)")
                                .foregroundStyle(.verdeLima)
                        }
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        
                        //proxima atividade
                        if let nextActivity = nextActivity, !nextActivity.isRest {
                            Text(nextActivity.name)
                                .font(.system(size: 13))
                                .foregroundStyle(.white)
                        }
                        
                        Button("Proximo") {
                            contador += 1
                            //Deep Seek: Updated to use ActivityPhase sequence
                            if contador < workoutPlan.phases.count {
                                timerViewModel.pauseTimer()
                                timerViewModel.endTimer()
                                timerViewModel.setTimerConfig(seconds: workoutPlan.phases[contador].duration)
                                timerViewModel.startTimer()
                            }
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RestView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
