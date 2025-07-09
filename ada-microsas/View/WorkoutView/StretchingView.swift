//
//  RestView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI
import SpriteKit

struct StretchingView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    @EnvironmentObject var router: Router
    
    //DEEP SEEK, THIS IS THE LINE THAT IS NOT COMPILING
    let stretchingScene = Stretching()
    
    var body: some View {
            ZStack{
                
                Image("StretchingImage")
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 35){
                    SpriteView(scene: stretchingScene, options: [.allowsTransparency])
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                        .padding(.leading, 45)
                        
                    
                    VStack(spacing: 10){
                        Text("Alongamento")
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Text("Alongue o corpo todo, sem pressa.")
                    }
                    
                    NavigationLink{
                        ActivityView()
                            .environmentObject(planViewModel)
                            .environmentObject(timerViewModel)
                            .environmentObject(router)
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
            .foregroundStyle(.white)
            .ignoresSafeArea(.all)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //dismiss()
                        router.popToRoot()
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
    }
}

#Preview{
    StretchingView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
        .environmentObject(Router())
}
