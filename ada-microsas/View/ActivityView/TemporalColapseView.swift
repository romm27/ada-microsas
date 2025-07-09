//
//  TemporalColapseView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 06/07/25.
//

import SwiftUI
    
struct TemporalColapseView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Temporal")
                    .resizable()
                    .scaledToFill()
                
                VStack {
                    Button {
                        timerViewModel.pauseTimer()
                        timerViewModel.endTimer()
                        timerViewModel.allTheOnesFinished()
                    } label: {
                        NavigationLink(destination: TrailView()) {
                            HStack {
                                Spacer()
                                Text("Voltar no Tempo")
                                    .padding(.vertical, 12)
                                    .foregroundStyle(.quasePreto)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .background(.verdeLimaBotao)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 100)
                .padding(.horizontal, 32)
            }
            .navigationBarBackButtonHidden(true)
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TemporalColapseView()
}
