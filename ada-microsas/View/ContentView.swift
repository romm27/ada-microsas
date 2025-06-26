//
//  ContentView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Color.roxo
                    .ignoresSafeArea(edges: .all)
                NavigationLink(destination: TrainerSheetView()){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit( )
                            .frame(width: 225)
                    }
                 
                }
             
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
