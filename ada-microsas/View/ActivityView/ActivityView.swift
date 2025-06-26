//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    
//    @State var progressValue: Double = 0.0
    
    @State var showCompletionAlert: Bool = false
    
    
    
    var body: some View {
        
        
        
        VStack {
            Text("Você tá\namassando!")
                .padding(.top, 84)
                .padding(.bottom, 40)
                .padding(.horizontal, 100)
                .multilineTextAlignment(.center)
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(.roxo)
        .cornerRadius(20)
        .ignoresSafeArea(.all)
        
        Spacer()
        
        VStack{
            ProgressBarView()
                .frame(width: 300, height: 300)
                .padding(100)
            
            
//            Button("Corre Aí"){
//                withAnimation(.easeInOut(duration: 1.0)){
//                    if (progressValue) < 0.7 {
//                        self.progressValue += 0.1
//                    } else {
//                        progressValue -= 0.7
//                        showCompletionAlert = true
//                    }
//                }
//            }
            
            
            .alert("Parabéns!", isPresented: $showCompletionAlert) {
                Button("Ok") {}
            } message: {
                Text("Você concluiu a atividade!")
            }
        }
        
        
        Spacer()
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
            .onAppear{
                //vai existir uma Activity aqui, para setar o timer
                //TODO: Mudar aqui para Activity.seconds
                    //a activity vai vir como Binding(eu acho?) da nossa TrilhaView > ModalView
                timerViewModel.setTimerConfig(seconds: 10)
                timerViewModel.startTimer()
            }
    }
    
    
}



#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
}
