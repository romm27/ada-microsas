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
    

    var onResume: () -> Void
    
    
    enum PlayerState{
        case play
        case pause
        case stop
    }
    
    @State var state: PlayerState = .play
    @State var showAlert: Bool = false
    @State var showEndingAlert: Bool = false
    @State var showColapseView: Bool = false
    
    
    var body: some View {
        
        HStack{
            //            if state == .play{
            //                Button(action: {
            //                    withAnimation {
            ////                        loigica do tempo
            //                        timerViewModel.pauseTimer()
            //                        state = .pause
            //
            ////                        timerViewModel.setTimerConfig(seconds: 60)
            //
            //
            //                    }
            //                }) {
            //                    Image(systemName: "pause.fill")
            //                        .font(.largeTitle)
            //                        .padding(15)
            //                        .background(.brancoGelo)
            //                        .foregroundColor(.cinzaClaro)
            //                        .clipShape(Circle())
            //                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 4)
            //                }
            //
            //
            //            }
            if state == .play {
                Button(action: {
                    //logica do tempo
                    timerViewModel.pauseTimer()
                    NotificationManager.shared.cancelAllNotifications()
                    state = .pause
                    
                }) {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 28))
                        .padding(12)
                        .background(.brancoGelo)
                        .foregroundColor(.cinzaClaro)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 10)
                }
                
                
                .padding(.horizontal)
                
                Button(action: {
                    showAlert.toggle()
                }) {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 28))
                        .padding(12)
                        .background(.brancoGelo)
                        .foregroundColor(.cinzaClaro)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 10)
                }
                
                .alert("Cuidado!", isPresented: $showAlert) {
                    Button("Voltar", role: .cancel) {
                        //logica do tempo
                    }
                    
                    NavigationLink(destination: TemporalColapseView()){
                        Button("Encerrar", role: .destructive) {
                            //timerViewModel.endTimer()
                            timerViewModel.pauseTimer()
                            timerViewModel.endTimer()
                            showColapseView.toggle()
                            
                            //dismiss()
                            //logica de encerrar
                        }
                    }
                    
                }
                
                message: {
                    Text("Se você encerrar agora, vai perder todo o seu progresso. Tem certeza?")
                }
                
                
                
                
            } else if state == .pause {
                
                Button(action: {
                    withAnimation {
                        timerViewModel.startTimer()
                        state = .play
                        onResume()
                    }
                }) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 28))
                        .padding(12)
                        .background(.cinzaClaro)
                        .foregroundColor(.brancoGelo)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 4)
                }
                
                .padding(.horizontal)
                
                Button(action: {
                    showAlert.toggle()
                }) {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 28))
                        .padding(12)
                        .background(.cinzaClaro)
                        .foregroundColor(.brancoGelo)
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.35), radius: 4, x: 0, y: 10)
                }
                
                .alert("Cuidado!", isPresented: $showAlert) {
                    Button("Voltar", role: .cancel) {
                        //logica do tempo
                    }
                    
                    NavigationLink(destination: TemporalColapseView()){
                        Button("Encerrar", role: .destructive) {
                            //timerViewModel.endTimer()
                            timerViewModel.pauseTimer()
                            timerViewModel.endTimer()
                            showColapseView.toggle()
                            
                            //dismiss()
                            //logica de encerrar
                        }
                    }
                    
                }
                
                message: {
                    Text("Se você encerrar agora, vai perder todo o seu progresso. Tem certeza?")
                }
                
                
            }
        }
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    ButtonView()
}
