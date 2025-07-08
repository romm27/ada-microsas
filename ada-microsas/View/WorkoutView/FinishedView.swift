//
//  FinishedView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 08/07/25.
//

import SwiftUI

struct FinishedView: View {
    var body: some View {
        ZStack{
            Image("BackgroundFinished")
                .resizable()
                .scaledToFill()
            
            VStack{
                Image("BelezinhaAlongamento")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                VStack(spacing: 30){
                    VStack(spacing: 10){
                        Text("Parabéns!")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.azulBotao)
                        Text("Você avançou mais um pouco até sua máquina do tempo")
                        
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.quasePreto)
                            .multilineTextAlignment(.center)
                    }
                    
                    .padding(.vertical, 16)
                    HStack(spacing: 8){
                        Spacer()
                        VStack(alignment: .leading, spacing: 8){
                            Text("Tempo")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
                            Text("00:21:30")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.brancoGelo)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 8){
                            Text("Exercício")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.cinzaMuitoClaro)
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
                }
                
                .background(.brancoGelo)
                .cornerRadius(16)
            }
            
            
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    FinishedView()
}
