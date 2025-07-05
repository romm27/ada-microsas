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

struct TabOnBoardingView02: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    let dataModel = DataOnBoardingModel()
    @State var index = 0
    @State private var navigateToHome = false
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                VStack{
                    Image(dataModel.cardsList[index].image)
                        .resizable()
                        .scaledToFill()
                        
                }
                .ignoresSafeArea(.all)
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.5), value: index)
                .preferredColorScheme(.dark)
                
                
                
                VStack{
                    Spacer()
                    
                    HStack(spacing: 24){
                        //voltar
                        if index >= 1{
                            Button{
                                if index > 0 {
                                    index -= 1
                                }
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.black)
                                        .frame(width: 35, height: 35)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                        }

                        
                        
                        //proximo
                        if index < dataModel.cardsList.count - 1 {
                            Button {
                                index += 1
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(width: 35, height: 35)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            
                        } else {
                            NavigationLink(destination: WorkoutView(currentIndex: 0)) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(width: 40, height: 40)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                        
                        }
                    
                    
                }
                .padding(.bottom, 30)

                
            }
        }
        
       
        
        
    }
}



#Preview {
    TabOnBoardingView02()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
