//
//  TrainerDetailedView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import SwiftUI

struct TrainerSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 40){
                    
                    HStack{
                       Image("monstrinho")
                        
                        //infos do treino
                        VStack(alignment: .leading, spacing: 20){
                            Text("Treino de hoje")
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.top, 50)
                                
                            Text("1. Pizza ipsum dolor amet chicken wing\n2. chicken and bacon meat lovers, bacon \n3. tomato anchovies ham ricotta \n4. sausage.")
                                .font(.caption)
                                .fontWeight(.light)
                                .padding(.bottom, 50)
                        }
                        .padding(.horizontal, 20)
                        .background(Color.brancoGelo)
                        .cornerRadius(16)
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 4)
                        
                    }
                    
                    
                    NavigationLink(destination: ActivityView()){
                        Text("Start Running")
                            .padding(.horizontal, 72)
                            .padding(.vertical, 12)
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .background(Color.roxo.opacity(0.5))
                            .cornerRadius(16)
                            
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 80)
                .background(Color.gray.opacity(0.2))
                    
                    
                
            }
        }
    
}

#Preview {
    TrainerSheetView()
        .environmentObject(TimerViewModel())
}
