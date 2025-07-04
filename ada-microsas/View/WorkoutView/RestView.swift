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
    let dataTrainingModel = DataTrainingModel()
    let currentIndex: Int
    
    var body: some View {
        
        
        VStack(spacing: 35){
            Image("BelezinhaDescanso")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            
            //
            VStack(spacing: 10){
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
                    .onAppear(){
                        timerViewModel.pauseTimer()
                        timerViewModel.endTimer()
                        timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[0])
                        timerViewModel.startTimer()
                    }
                
                //proxima atividade
                VStack(spacing: 20){
                    //proxima atividade
                    VStack(spacing: 5){
                        HStack{
                            //titulo
                            Text("Próxima Atividade")
                            //contador fraçao
                            Text("\(contador + 1)/\(dataTrainingModel.trainingList[currentIndex].warmingUp.warmUpRest.count)")
                                .foregroundStyle(.verdeLima)
                        }
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        //proxima atividade
                        if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                            if contador < Warming.warmUp.count {
                                Text(Warming.warmUp[contador])
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        
                        Button("Proximo"){
                            contador += 1
                            if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                                if contador < DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp.count{
                                    timerViewModel.pauseTimer()
                                    timerViewModel.endTimer()
                                    timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
                                    
                                    timerViewModel.startTimer()
                                }
                            }
                            
                            
                        }
                        
                    }
                }
                
            }

            
            
        }
        
        .preferredColorScheme(.dark)
    }
}

#Preview{
    RestView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
