//
//  TimerTestView.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import SwiftUI

struct TimerTestView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Text("This is a Timer")
            .font(.system(size: 28, weight: .regular))
        
        Button{
            timerViewModel.setTimerConfig(seconds: 20)
        }label:{
            Text("Set Timer Config")
        }
        
        Text("Current time: \(timerViewModel.getCurrentTimer())") //nao ta mostrandooo cossorro
        
        
        //Botao running ou paused de acordo com o Status
        //O botao nao ta atualizando nem pausando
        switch timerViewModel.timerStatus {
        case .running:
            Text("Running")
            Button{
                timerViewModel.pauseTimer()
            }label:{
                ZStack{
                    Rectangle()
                        .frame(width: 50, height: 50)
                    Image(systemName: "pause")
                        .foregroundStyle(.white)
                }
            }
        case .paused:
            Text("Paused")
            Button{
                timerViewModel.startTimer2()
            }label:{
                ZStack{
                    Circle()
                        .frame(width: 50)
                    Image(systemName: "play")
                        .foregroundStyle(.white)
                }
            }
        }
        
    }
}

#Preview {
    TimerTestView()
        .environmentObject(TimerViewModel())
}
