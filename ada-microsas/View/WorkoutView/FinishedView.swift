//
//  FinishedView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 08/07/25.
//

import SwiftUI

struct FinishedView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        ZStack{
            Image("BackgroundFinished")
                .resizable()
                .scaledToFill()
            VStack(spacing: 36){
                Image("BelezinhaAlongamento")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                VStack(spacing: 16){
                    VStack(spacing: 16){
                        Text("Parabéns!")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.azulBotao)
                        Text("Você avançou mais um pouco até sua máquina do tempo")
                            .lineSpacing(12)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.cinzaMedio)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    HStack(spacing: 24){
                        Spacer()
                        VStack(alignment: .leading, spacing: 8){
                            Text("Tempo da Atividade")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
                            //MARK: MUDAR O TEMPO AGUI
                            Text("00:21:30")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.brancoGelo)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 8){
                            Text("Nível")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
                            //TODO: MUDAR O NIVEL AGUI
                            Text("03/24")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.brancoGelo)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                    .background(.cinzaMedio)
                    .clipShape(
                        .rect(cornerRadii: .init(bottomLeading: 16, bottomTrailing: 16))
                    )
                }
                .background(.brancoGelo)
                .cornerRadius(16)
                .padding(.horizontal, 32)
                
                VStack{
                    NavigationLink{
                        TrailView()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Continuar")
                                .padding(.vertical, 12)
                                .foregroundStyle(.quasePreto)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(.verdeLimaBotao)
                        .cornerRadius(8)
                        .padding(.horizontal, 32)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            timerViewModel.pauseTimer()
                            timerViewModel.endTimer()
                            timerViewModel.allTheOnesFinished()
                        }
                    )
                }
            }
            .padding(.bottom, 120)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    FinishedView()
        .environmentObject(TimerViewModel())
}
