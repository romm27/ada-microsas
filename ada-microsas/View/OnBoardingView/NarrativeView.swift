
//  NarrativeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 09/07/25.
//

import SwiftUI

struct NarrativeView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    let dataModel = DataOnBoardingModel()
    @State private var navigateToHome = false
    
    var body: some View {
        TabView{
            Image(dataModel.cardsList[3].image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            Image(dataModel.cardsList[4].image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            ZStack{
                Image(dataModel.cardsList[5].image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                NavigationLink(destination: TrailView()){
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Vamos Lá!")
                                .padding(.vertical, 12)
                                .foregroundStyle(.quasePreto)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(.verdeLima)
                        .cornerRadius(8)
                        
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 120)
                    
                }
                .environmentObject(planViewModel)
                .environmentObject(timerViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}


#Preview {
    NarrativeView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
