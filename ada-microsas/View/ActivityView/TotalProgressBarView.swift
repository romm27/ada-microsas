//
//  TotalProgressBarView.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 03/07/25.
//

import SwiftUI

struct TotalProgressBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    let fakeProgress = 0.5
    
    var progressText: String {
        "\(Int(timerViewModel.progress * 100))%"
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Progresso Total")
                .font(.caption)
                .fontWeight(.regular)
                .foregroundStyle(.brancoGelo)
            ZStack{
                ZStack(alignment: .leading){
                    
                    Rectangle()
                        .frame(width: 300, height: 25)
                        .cornerRadius(24)
                        .foregroundStyle(.brancoGelo)
                    ZStack{
                        Rectangle()
                    .frame(width: (300*timerViewModel.progress), height: 25)
    //                        .frame(width: (300*fakeProgress), height: 25)
                            .cornerRadius(24)
                            .foregroundStyle(.roxo)
                            .animation(.interpolatingSpring, value: timerViewModel.progress)
                        
                        HStack{
                            Spacer()
                            Image(systemName: "figure.run")
                                .padding(.trailing, 8)
                                .foregroundStyle(.brancoGelo)
                                .animation(.interpolatingSpring, value: timerViewModel.progress)
                        }
    //                    .frame(width: (300*fakeProgress))
                        .frame(width: (300*timerViewModel.progress))
                    }
                }
                
                ZStack(alignment: .trailing){
                    HStack{
                        Spacer()
                        Text(progressText)
                            .foregroundStyle(.cinzaClaro)
                            .padding(.trailing, 8)
                    }
                    .frame(width: 300)
                    
                }
                
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TotalProgressBarView()
        .environmentObject(TimerViewModel())
}
