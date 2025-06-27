//
//  TrainerDetailedView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import SwiftUI

struct TrainerSheetView: View {
    
   
    let dataTrainingModel = DataTrainingModel()
    

    
    @Environment(\.dismiss) var dismiss
    
    
    let currentIndex: Int
    
    @Binding var shouldStartActivity: Bool
    
    

    
    
    var body: some View {
        
        ZStack{
            Color("brancoGelo").ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 16){
                //imagem
                Image("workout")
                    .resizable()
                    .scaledToFit( )
                    .frame(width: 200)
                
                //details
                VStack(alignment: .leading, spacing: 12){
                    //warm-up
                    VStack(alignment: .leading, spacing: 4){
                        //titulo
                        Text("Aquecimento (10 minutos)")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        
                        //infos
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(dataTrainingModel.trainingList[currentIndex].warmingTraining, id: \.self) { warmingTraining in
                                Text(warmingTraining)
                            }
                        }
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundStyle(.quasePreto)
                    }
                    
                    //treino principal
                    VStack(alignment: .leading){
                        //titulo
                        Text("Treino Principal")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        //infos
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(dataTrainingModel.trainingList[currentIndex].mainTraining, id: \.self) { mainTraining in
                                Text(mainTraining)
                                
                            }
                            
                        }
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundStyle(.quasePreto)
                        
                    }
                    
                    
                    //treino principal
                    VStack(alignment: .leading){
                        //titulo
                        Text("Descanso (10 minutos)")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        //infos
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(dataTrainingModel.trainingList[currentIndex].restTraining, id: \.self) { restTraining in
                                Text(restTraining)
                            }
                        }
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundStyle(.quasePreto)
                    }

                }
                .padding(.horizontal, 32)
                
                //fazer rectangle com path
                //objetivo
                VStack(alignment: .leading){
                    Text("Objetivo:")
                        .font(.headline)
                        .foregroundStyle(.roxo)

                    Text(dataTrainingModel.trainingList[currentIndex].objectiveTraining)
                        .font(Font.system(size: 14))
                        .fontWeight(.light)
                        .foregroundStyle(.quasePreto)
                }
                
                //botao
                VStack{
                    Button(action: {
                  
                            shouldStartActivity = true
                            dismiss()
                        
                        
                    }) {
                        HStack{
                            Spacer()
                            Text("Começar a Correr")
                            Spacer()
                        }
                        .padding(.horizontal, 72)
                        .padding(.vertical, 12)
                        .background(.roxo)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .cornerRadius(8)
                    }
                    
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .background(.brancoGelo)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    TrainerSheetView(currentIndex: 0, shouldStartActivity: .constant(false))
}
