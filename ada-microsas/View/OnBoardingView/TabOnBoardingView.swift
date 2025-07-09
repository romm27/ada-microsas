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
    
    let dataModel = DataOnBoardingModel()
    @State private var navigateToHome = false
    
    var body: some View {
        TabView{
            Image(dataModel.cardsList[0].image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            Image(dataModel.cardsList[1].image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            NavigationLink(destination: WorkoutView(currentIndex: 0)){
                ZStack{
                    Image(dataModel.cardsList[2].image)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Continuar")
                                .padding(.vertical, 12)
                                .foregroundStyle(.quasePreto)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(.verdeLimaBotao)
                        .cornerRadius(8)
                        .padding(.horizontal, 32)
                    }
                    .padding(.bottom, 100)
                    
                }
            }
            .environmentObject(planViewModel)
            .environmentObject(timerViewModel)
        }
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
                    .font(.body)
                    .fontWeight(.bold)
                }
            }
        }
        .ignoresSafeArea(.all)
        .tabViewStyle(PageTabViewStyle())
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity)
        .background(.black)
    }
}



#Preview {
    ContentView()
        .environmentObject(TimerViewModel()).environmentObject(PlanViewModel())
//    TabOnBoardingView()
//        .environmentObject(TimerViewModel())
//        .environmentObject(PlanViewModel())
}
