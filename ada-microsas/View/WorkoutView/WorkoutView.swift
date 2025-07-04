//
//  WorkoutView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct WorkoutView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var showCompletionAlert: Bool = false
    

    let dataTrainingModel = DataTrainingModel()
    let currentIndex: Int
    
    var totalTime: Int {
        let warmUpTimes = dataTrainingModel.trainingList[currentIndex].warmingUp.timeWarmUp
        let warmUpCountTimes = dataTrainingModel.trainingList[currentIndex].warmingUp.warmUpCount
        let warmUpRestTimes = dataTrainingModel.trainingList[currentIndex].warmingUp.warmUpRest
        let mainTrainingTimes = dataTrainingModel.trainingList[currentIndex].mainTraining.timeMainTraining
        let mainTrainingCountTimes = dataTrainingModel.trainingList[currentIndex].mainTraining.mainTrainingCount
        
        var totalWarmUp = 0
        for time in warmUpTimes {
            totalWarmUp += time
        }
        
        var totalWarmUpRest = 0
        for time in warmUpRestTimes {
            totalWarmUpRest += time
        }
        
        var totalMainTraining = 0
        for time in mainTrainingTimes {
            totalMainTraining += time
        }
        
        let totalSeconds = (totalWarmUp * warmUpCountTimes) + (totalMainTraining * mainTrainingCountTimes) + totalWarmUpRest
        
        return totalSeconds / 60
    }
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.quasePreto
                Image("BackgroundColorfull")
                    .resizable()
                    .scaledToFit( )
                    
                    .offset(y: 150)
                    
                
                VStack(spacing: 48){
                    
                    Spacer()
                    
                    ZStack{
                        Image("DashedRectangle")
                        HStack{
                            Image(systemName: "figure.flexibility")
                            Text("Alongue o corpo todo, sem pressa.")
                        }
                    }
                    .padding(.top, 60)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    
                    
                    
                    //RETANGULO BRANCO
                    VStack(alignment: .leading, spacing: 40){
                        
                        ZStack{
                            HStack{
                                Spacer()
                                
                                ZStack{
                                    Image("Star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90)
                                        .offset(y: -70)
                                    //MUDAR AQUI
                                    Text("\(totalTime)'")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .offset(y: -70)
                                }
                            }
                            
                            //AQUECIMENTO
                            VStack(alignment: .leading){
                                Text("Aquecimento (\(dataTrainingModel.trainingList[currentIndex].warmingUp.warmUpCount)x)")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 8)
                                
                                ForEach(Array(dataTrainingModel.trainingList[currentIndex].warmingUp.timeWarmUp.enumerated()), id: \.offset) { idx, time in
                                    //                            [Int] -> Array
                                    HStack{
                                        Image(systemName: "figure.walk")
                                            .font(.system(size: 20))
                                            .padding(.trailing, 24)
                                        VStack(alignment: .leading){
                                            Text("\(Warming.warmUp[idx])")
                                                .font(.system(size: 12))
                                                .fontWeight(.regular)
                                            Text("\(time)\"")
                                                .font(.system(size: 12))
                                                .fontWeight(.bold)
                                        }
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 8)
                                    Divider()
                                    
                                }
                            }
                        }
                        //TREINO PRINCIPAL
                        VStack(alignment: .leading){
                            Text("Treino Principal (\(dataTrainingModel.trainingList[currentIndex].mainTraining.mainTrainingCount)x)")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom, 8)
                            
                            ForEach(Array(dataTrainingModel.trainingList[currentIndex].mainTraining.timeMainTraining.enumerated()), id: \.offset) { idx, time in
                                
                                HStack{
                                    Image(systemName: "figure.run")
                                        .font(.system(size: 20))
                                        .padding(.trailing, 24)
                                    VStack(alignment: .leading){
                                        Text("\(MainTraining.mainTraining[idx])")
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                        Text("\(time)\"")
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.horizontal, 25)
                                .padding(.vertical, 8)
                                Divider()

                            }
                        }
                        
                        
                        //                        ForEach(0..<Warming.warmUp.count) { idx in
                        ////                            [Int] -> Array
                        //
                        //                                VStack{
                        //                                    Text("\(Warming.warmUp[idx])")
                        //                                        .foregroundStyle(.white)
                        //                                    Text("\(dataTrainingModel.trainingList[currentIndex].warmingUp.timeWarmUp[idx])")
                        //                                        .foregroundStyle(.white)
                        //                                }
                        //                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    
                    
                    NavigationLink{
                        StretchingView()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Começar a Correr")
                                .padding(.vertical, 12)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(.roxo)
                        .cornerRadius(8)
                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 32)
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "arrow.backward")
                                Text("Treino de Hoje")
                            }
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            //.offset(y: 40)
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
        
        
    }
    
}

#Preview {
    WorkoutView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
