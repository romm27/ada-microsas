//
//  TrainerDetailedView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import SwiftUI

struct TrainerSheetView: View {
    
    let dataTrainingModel = DataTrainingModel()
    
    @State var currentIndex = 0
    
    
    var body: some View {
        
        
        NavigationStack{
            
            
            
            
            VStack(alignment: .leading, spacing: 40){
                //imagem
                Image("workout")
                    .resizable()
                    .scaledToFit( )
                    .frame(width: 300)
                
                
                
                
                
                //details
                VStack(alignment: .leading, spacing: 32){
                    //warm-up
                    VStack(alignment: .leading, spacing: 4){
                        //titulo
                        Text("Aquecimento (10 minutos)")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        
                        //infos
                        VStack(alignment: .leading){
                            ForEach(dataTrainingModel.trainingList[currentIndex].warmingTraining, id: \.self) { warmingTraining in
                                Text(warmingTraining)
                            }
                        }
                        .font(.body)
                        .fontWeight(.light)
                    }
                    
                    
                    
                    
                    //treino principal
                    VStack(alignment: .leading){
                        //titulo
                        Text("Treino Principal")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        //infos
                        VStack(alignment: .leading){
                            ForEach(dataTrainingModel.trainingList[currentIndex].mainTraining, id: \.self) { mainTraining in
                                Text(mainTraining)
                            }
                        }
                        .font(.body)
                        .fontWeight(.light)
                    }
                    
                    //treino principal
                    VStack(alignment: .leading){
                        //titulo
                        Text("Descanso (10 minutos)")
                            .font(.headline)
                            .foregroundStyle(.roxo)
                        //infos
                        VStack(alignment: .leading){
                            ForEach(dataTrainingModel.trainingList[currentIndex].restTraining, id: \.self) { restTraining in
                                Text(restTraining)
                            }
                        }
                        .font(.body)
                        .fontWeight(.light)
                    }
                    
                    
                    
                    
//                    VStack(alignment: .leading){
//                        //titulo
//                        Text("Descanso (10 minutos)")
//                            .font(.headline)
//                            .foregroundStyle(.roxo)
//                        //infos
//                        VStack(alignment: .leading){
//                            ForEach(dataTrainingModel.trainingList[currentIndex].restTraining, id: \.self) { restTraining in
//                                Text(restTraining)
//                            }
//                        }
//                        .font(.body)
//                        .fontWeight(.light)
//                    }
                }
                
            }
        }
        
        
    }
}

#Preview {
    TrainerSheetView()
}
