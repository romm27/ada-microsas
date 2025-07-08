//
//  RestView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct StretchingView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                
                Image("StretchingImage")
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 35){
                    Image("BelezinhaAlongamento")
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
                    
                    NavigationLink{
                        ActivityView()
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
                .padding(.horizontal, 32)
            }
            
            
            .ignoresSafeArea(.all)
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Voltar")
                            .foregroundColor(.white)
                    }
                    .font(.system(.body, weight: .bold))
                }
            }
        }

        
        .preferredColorScheme(.dark)
    }
    
}

#Preview{
    StretchingView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
