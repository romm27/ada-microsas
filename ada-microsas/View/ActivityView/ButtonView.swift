//
//  ButtonView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

struct ButtonView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    
    enum PlayerState{
        case play
        case pause
        case stop
    }
   
    @State var state: PlayerState = .play
    @State var showAlert: Bool = false
    @State var showEndingAlert: Bool = false
    
    
    var body: some View {
        
        HStack{
            if state == .play{
                Button(action: {
                    //loigica do tempo
                    timerViewModel.pauseTimer()
                    state = .pause
                }) {
                    Image(systemName: "pause.fill")
                        .font(.largeTitle)
                        .padding(15)
                        .background(.brancoGelo)
                        .foregroundColor(.cinzaClaro)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 4)
                }
                
                
            } else if state == .pause {
                Button(action: {
                    //logica do tempo
                    timerViewModel.startTimer()
                    state = .play
                    
                }) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .padding(15)
                        .background(.cinzaClaro)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 10)
                }
                
                
                .padding(.horizontal)
                
                Button(action: {
                    showAlert.toggle()
                }) {
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .padding(15)
                        .background(.cinzaClaro)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 10)
                }
                
                .alert("Cuidado!", isPresented: $showAlert) {
                    Button("Voltar", role: .cancel) {
                        //logica do tempo
                    }
                    
                    Button("Encerrar", role: .destructive) {
                        state = .stop
                        showEndingAlert.toggle()
                        //logica de encerrar
                    }
                                        
                }
                
                message: {
                    Text("Se você encerrar agora, vai perder todo o seu progresso. Tem certeza?")
                    }
                
                
                
            } else if state == .stop {
            
                Button(action: {
                    state = .play
                }) {
                    //COMEÇA DE NOVO SO PARA TESTE!!
                    Text("Reiniciar Teste")
                        .font(.largeTitle)
                    }
            }
        }
        
        
        //alerta de encerramento antes de concluir atividade
        .alert("Colapso Temporal", isPresented: $showEndingAlert) {
            Button("Ok") {
                timerViewModel.endTimer()
            }
                } message: {
                    Text("Sua máquina do tempo corrompeu.")
                }
                .preferredColorScheme(.dark)

    }
}

#Preview {
    ButtonView()
}
