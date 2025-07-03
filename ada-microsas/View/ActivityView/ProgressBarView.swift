//
//  ProgressView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI
import SpriteKit

struct ProgressBarView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel

    // Define o tamanho total do arco (70% do círculo)
    private let totalArc: CGFloat = 0.7
    
    var body: some View {
        ZStack{
//            SpriteView(scene: <#T##SKScene#>)
            //circle gray
            Circle()
                .trim(from: 0, to: totalArc)
                .stroke(style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                .opacity(0.25)
                .foregroundStyle(Color.gray)
                .rotationEffect(Angle(degrees: 144))
            
            //circle green
            Circle()
//                .trim(from: 0.0, to: CGFloat(min(self.progress, 0.7)))
                .trim(from: 0, to: CGFloat(timerViewModel.progress) * 0.7)
                .stroke(style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [Color.roxo, Color.verdeLima]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .animation(.interpolatingSpring, value: timerViewModel.progress)
              
            //degree starts at 12`o
                .rotationEffect(Angle(degrees: 144))
            
           
            
            
//            Text("\(Int((self.progress / 0.7) * 100))%")
//                .font(.system(size: 16))
//                .fontWeight(.regular)
//                .foregroundStyle(Color.primary)
//                .offset(y: -150)
            
            Text("\(Int((timerViewModel.progress) * 100))%")
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundStyle(Color.primary)
                .offset(y: -150)
            
            
            
            VStack(spacing: 20){
                
              Spacer()
                
                Text("Tempo")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)


                Text("\(timerViewModel.getFormattedCurrentTimer())")
                    .font(.system(size: 56))
                    .fontWeight(.semibold)
                
           Spacer()
                
                ButtonView()
                
            }
          
        }
    }
}

#Preview {
    ProgressBarView()
        .environmentObject(TimerViewModel())
}
