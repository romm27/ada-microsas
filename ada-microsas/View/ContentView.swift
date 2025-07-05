//
//  ContentView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State private var showSplash = true
    
    init(){
        
    }
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                
                if showSplash{
                    SplashScreenView()
                        .transition(.opacity)
                    
                } else {

                    
                    TabOnBoardingView()
                        .environmentObject(planViewModel)
                        .transition(.opacity)
                    
                }
                
      
            }
            .ignoresSafeArea(.all) //É AQUIIIIIII
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation{
                        self.showSplash = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerViewModel()).environmentObject(PlanViewModel())
}
