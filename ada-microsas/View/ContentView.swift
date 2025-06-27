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
    
    init(){
        
    }
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color.roxo
                    .ignoresSafeArea(edges: .all)
                NavigationLink(destination: TrailView(trail: DataTrainingModel.shared.trainingList, userLevel: planViewModel.userLevel)){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit( )
                            .frame(width: 225)
                    }
                 
                }
                .navigationBarBackButtonHidden()
             
                    
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerViewModel()).environmentObject(PlanViewModel())
}
