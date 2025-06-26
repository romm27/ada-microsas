//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

struct ActivityView: View {
    
    @State var progressValue: Float = 0.0
    
    var body: some View {
        ProgressView(progress: self.$progressValue)
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
                }
            }
          
        }
    }
}

#Preview {
    ActivityView()
}
