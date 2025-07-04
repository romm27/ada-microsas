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
        VStack{
            ZStack{
                Image("BackgroundAquecimento")
                
                VStack(spacing: 5){
                    Image("BelezinhaAquecimento")
                        .padding(8)
                    Text("Treino")
                        .font(.callout)
                        .fontWeight(.regular)
                    Text("Trote")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 48)
            }
            
            Spacer()
            
            ProgressBarView()
                .frame(width: 300, height: 300)
                .alert("Parabéns!", isPresented: $timerViewModel.isFinished) {
                    Button("Ok") {
                        planViewModel.userLevel += 1
                        dismiss()
                    }
                } message: {
                    Text("Você concluiu a atividade!")
                }
            
            Spacer()
            
            TotalProgressBarView()
            
            Spacer()
            
            //Aqui vamos colocar alguma funcao do TimerViewModel que mude quando o timer finalizar
            Button("Proximo"){
                
                contador += 1
                
                
                //User está num level válido(1-24) >>  se user level é menor que a quantidade de treinos
                if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                    //contador é o index da array do aquecimento ou da corrida
                    //se esse contador/index for menor que a quantidade de intervalos do treino do level que estamos
                    if contador < DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp.count{
                        
                        //seta o timer com os segundos do intervalo que estamos com o contador/index
                        //starta o timer (que só vai passar para o próximo count quando terminar)
                        timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
                        
                        timerViewModel.startTimer()
                    }
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
        .ignoresSafeArea(.all)
        .onAppear{
            print(" USER LEVEL: \(planViewModel.userLevel)")
            //inicia so o primeiro
            timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
            timerViewModel.startTimer()
        }
    }
    
    
}



#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
