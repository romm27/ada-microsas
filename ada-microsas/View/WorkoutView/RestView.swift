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
            
            VStack(spacing: 32){
                VStack(spacing: 56){
                    
                    VStack(spacing: 20){
                        Image("BelezinhaDescanso")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        VStack(spacing: 10){
                            Text("Descansar")
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Text("00:30")
                                .font(.system(size: 58))
                                .fontWeight(.regular)
                                .foregroundStyle(.verdeLima)
                        }
                        
                        VStack(spacing: 10) {
                            Text("Próxima Atividade")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("Salto na Ponta do Pé")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                    }
                    
                    ButtonView()
                        .padding(.trailing, 12)
                }
                
                VStack{
                    Button{
                        //action
                        //onSkip()
                    }
                    label: {
                        Text("Pular")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.verdeLima)
                            .padding(.vertical, 10)
                        
                    }
                }
                
                ZStack{
                    HStack(spacing: 60){
                        VStack(alignment: .leading){
                            Text("Tempo")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
                            Text("00:00:00")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.brancoGelo)
                        }
                        .padding(.leading, 20)
                        
                        
                        VStack(alignment: .leading){
                            Text("Progresso")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
                            Text("00%")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.brancoGelo)
                        }
                        .padding(.trailing)
                    }
                    .padding(24)
                    .padding(.horizontal, 20)
                }
                .background(.cinzaMedio)
                .cornerRadius(16)
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
