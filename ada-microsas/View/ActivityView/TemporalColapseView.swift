//
//  TemporalColapseView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 06/07/25.
//

import SwiftUI

struct TemporalColapseView: View {
    @EnvironmentObject var planViewModel: PlanViewModel
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        ZStack {
            Image("Temporal")
                .resizable()
                .scaledToFill()
            
            VStack {
                Button {
                    timerViewModel.allTheOnesFinished()
                    timerViewModel.pauseTimer()
                    timerViewModel.endTimer()
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
                        .background(.verdeLima)
                        .cornerRadius(8)
                    }
                    .environmentObject(planViewModel)
                    .environmentObject(timerViewModel)

                }
            }
            .padding(.top, 220)
            .padding(.horizontal, 32)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TemporalColapseView()
        .environmentObject(PlanViewModel())
        .environmentObject(TimerViewModel())
}
