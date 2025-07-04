//
//  AtividadeView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI

enum StateActivity{
    case treino
    case aquecimento
    case descanso
}

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var test = false
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var showCompletionAlert: Bool = false
    
    @State var contador: Int = 0
    
    @State var state: StateActivity = .treino
    
    var body: some View {
        NavigationStack{
            Group{
                if timerViewModel.trainState == .resting{
                    RestView(currentIndex: contador)
                } else {
                    VStack{
                        switch state {
                        case .treino:
                            ZStack{
                                Image("BackgroundTreino")
                                
                                VStack(spacing: 5){
                                    Image("BelezinhaTreino")
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
                        case .aquecimento:
                            ZStack{
                                Image("BackgroundAquecimento")
                                
                                VStack(spacing: 5){
                                    Image("BelezinhaAquecimento")
                                        .padding(8)
                                    Text("Aquecendo")
                                        .font(.callout)
                                        .fontWeight(.regular)
                                    Text("Polichinelo")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 48)
                            }
                        case .descanso:
                            //carla aqui :)
                            Text("carla")
                        }
                        
                        Spacer()
                        
                        ProgressBarView()
                            .frame(width: 300, height: 300)
                        
                        
                        
        //                    .alert("Parabéns!", isPresented: $timerViewModel.isFinished) {
        //                        Button("Ok") {
        //                            planViewModel.userLevel += 1
        //                            dismiss()
        //                        }
        //                    } message: {
        //                        Text("Você concluiu a atividade!")
        //                    }
                        
                        Spacer()
                        
                        TotalProgressBarView()
                        
                        Spacer()
                            
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismiss()
//                        planViewModel.setLevel(0)
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .padding()
                        }
                        .font(.headline)
                        .foregroundStyle(.quasePreto)
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
            
            .onChange(of: $timerViewModel.isFinished.wrappedValue) { newValue in
                if newValue {
                    withAnimation{
                        timerViewModel.trainState = .resting
                    }
                    
                    passNextIntervalTraining()
                }
            }
        }
    }
    
    func passNextIntervalTraining() {
        if timerViewModel.trainState == .training{
            contador += 1
            
            
            //User está num level válido(1-24) >>  se user level é menor que a quantidade de treinos
            if planViewModel.userLevel < DataTrainingModel.shared.trainingList.count{
                //contador é o index da array do aquecimento ou da corrida
                //se esse contador/index for menor que a quantidade de intervalos do treino do level que estamos
                if contador < DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp.count{
                    
                    //seta o timer com os segundos do intervalo que estamos com o contador/index
                    //starta o timer (que só vai passar para o próximo count quando terminar)
                    timerViewModel.pauseTimer()
                    timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].warmingUp.timeWarmUp[contador])
                    
                    //chamar a rest view e só iniciar o timer depois
                    
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
