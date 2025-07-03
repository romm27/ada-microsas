//
//  TimerTeste.swift
//  ada-microsas
//
//  Created by Carla Araujo on 02/07/25.
//

import SwiftUI

struct TimerTeste: View {
    
    let timerTeste = DataTrainingModel()
    
    
    var body: some View {
        ForEach(timerTeste.trainingList){ timer in
            
            Text("oi")
        }
    }
}

#Preview {
    TimerTeste()
}
