//
//  TabOnBoardingView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 05/07/25.
//

//
//  TabOnBoardingView02.swift
//  ada-microsas
//
//  Created by Carla Araujo on 05/07/25.
//

//
//  TabOnBoardingView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 04/07/25.
//

import SwiftUI

struct TabOnBoardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    @EnvironmentObject var router: Router
    
    let dataModel = DataOnBoardingModel()
    @State private var navigateToHome = false
    
    var body: some View {
        
        NavigationStack{
            VStack{
                TabView{
                    Image(dataModel.cardsList[0].image)
                        .resizable()
                        .scaledToFill()
                    
                    Image(dataModel.cardsList[1].image)
                        .resizable()
                        .scaledToFill()
                    
                    NavigationLink(destination: WorkoutView(currentIndex: 0)){
                        ZStack{
                            Image(dataModel.cardsList[2].image)
                                .resizable()
                                .scaledToFill()
                            Text("Entendiiiiii")
                                .foregroundStyle(.white)
                        }
                    }
                    .environmentObject(planViewModel)
                    .environmentObject(timerViewModel)
                    .environmentObject(router)
                    
    
                }
                .tabViewStyle(PageTabViewStyle())
                .ignoresSafeArea(.all)
                .preferredColorScheme(.dark)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                        Text("Voltar")
                            .foregroundColor(.white)
                    }
                    .font(.system(size: 28, weight: .bold))
                }
            }
        }
        
       
        
        
    }
}



#Preview {
    TabOnBoardingView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
        .environmentObject(Router())
}
