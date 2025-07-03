//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
        
    @State var showCompletionAlert: Bool = false
    
    
    @State var contador: Int = 0

    
    var body: some View {
        VStack {
            Text("Você tá\namassando!")
                .padding(.top, 84)
                .padding(.bottom, 40)
                .padding(.horizontal, 100)
                .multilineTextAlignment(.center)
            
            //oiii afonso! aqui pensei: "hum se esta dando index out of range deve ser pq o level do user ta maior q o numero de treinos entao vou fazer uma verificacao... mas nndeu
            if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                if contador < Warming.warmUp.count {
                    Text(Warming.warmUp[contador])
                }
            }
            
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(.roxo)
        .cornerRadius(20)
        .ignoresSafeArea(.all)
        
        Spacer()
        
        VStack{
            ProgressBarView()
                .frame(width: 300, height: 300)
                .padding(100)
                .alert("Parabéns!", isPresented: $timerViewModel.isFinished) {
                    Button("Ok") {
                        planViewModel.userLevel += 1
                        dismiss()
                    }
                } message: {
                    Text("Você concluiu a atividade!")
                }
        }
        
        Spacer()
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
            .onAppear{
                print(" USER LEVEL: \(planViewModel.userLevel)")
                //inicia so o primeiro
                timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
                timerViewModel.startTimer()
            }
        
        Button("Proximo"){
            contador += 1
            

            if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                if contador < DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp.count{
                    
                    timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
                    
                    timerViewModel.startTimer()
                }
            }
            
            
        }
        
    }
    
    
}



#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
