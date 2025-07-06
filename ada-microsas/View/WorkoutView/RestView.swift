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
            
            Color.cinzaEscuro.edgesIgnoringSafeArea(.all)
            

            
            Image("RestImage")
                .resizable()
                .scaledToFill()
            
            VStack(spacing: 25) {
                
                VStack(spacing: 5) {
                    Text("Próxima Atividade")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Text("Salto na Ponta do Pé")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                }
                
                Image("BelezinhaDescanso")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                
                VStack(spacing: 25) {
                    Text("Descanso")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("00:30")
                        .font(.system(size: 35))
                        .fontWeight(.regular)
                        .foregroundStyle(.verdeLima)
                    
                    VStack{
                        ButtonView()
                            .padding(.trailing, 12)
                        
                        Button{}
                        label: {
                            Text("Pular")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)                        }
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
