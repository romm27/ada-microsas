//
//  RestView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct StretchingView: View {
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 35){
                Image("BelezinhaDescanso")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                VStack(spacing: 10){
                    Text("Alongamento")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Alongue o corpo todo, sem pressa.")
                }
                
                Button{
                    
                } label: {
                    HStack{
                        Spacer()
                        Text("Tô pronto!")
                            .padding(.vertical, 12)
                            .foregroundStyle(.quasePreto)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .background(.verdeLimaBotao)
                    .cornerRadius(8)
                    
                }
                
            }
        }
        .padding(.horizontal, 48)
        .preferredColorScheme(.dark)
    }
    
}

#Preview{
    StretchingView()
}
