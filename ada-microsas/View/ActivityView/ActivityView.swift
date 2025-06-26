//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

struct ActivityView: View {
    
    @State var progressValue: Float = 0.0
    @State var showCompletionAlert: Bool = false
    
 
    
    var body: some View {
        ProgressBarView(progress: self.$progressValue)
            .frame(width: 300, height: 300)
        //setando valor inicial so de referencia
            .padding(20.0).onAppear {
                self.progressValue = 0.0
            }
        
 
        Button("Increment"){
            withAnimation(.easeInOut(duration: 1.0)){
                if (progressValue) < 0.7 {
                    self.progressValue += 0.1
                } else {
                    progressValue -= 0.7
                    showCompletionAlert = true
                    
                }
            }
        }
              
            
        .alert("Parabéns!", isPresented: $showCompletionAlert) {
            Button("Ok") {}
            } message: {
                Text("Você concluiu a atividade!")
            }
        }
       
    }


#Preview {
    ActivityView()
}
