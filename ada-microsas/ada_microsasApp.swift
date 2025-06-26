//
//  ada_microsasApp.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

@main
struct ada_microsasApp: App {
    
    //Cria uma única instância do ViewModel que viverá durante todo o ciclo de vida do app.
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var planViewModel = PlanViewModel()
    
    var body: some Scene {
        WindowGroup {
            //Injeta o ViewModel no ambiente do SwiftUI.
            //Agora, qualquer view filha pode acessar este ViewModel.
            ContentView()
                .environmentObject(timerViewModel)
                .environmentObject(planViewModel)
        }
    }
    
}


#Preview {
    ContentView().environmentObject(TimerViewModel()).environmentObject(PlanViewModel())
}
