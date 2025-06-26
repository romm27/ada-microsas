//
//  TrilhaExemploAPAGAR.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import SwiftUI

struct TrilhaExemploAPAGAR: View {
    
    @State var showTrainerSheet = false
    
    
    
    var body: some View {
        
        Button("Clica aí vai"){
            showTrainerSheet.toggle()
        }
        .sheet(isPresented: $showTrainerSheet){
            TrainerSheetView()
                .presentationDetents([
                    //.medium, .large,
                    .medium, .large
                ])
        }
            
        
        
        
    }
}
