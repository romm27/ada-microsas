//
//  WorkoutView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct WorkoutView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var showCompletionAlert: Bool = false
    
    let currentIndex: Int
    
    //Deep Seek: Updated to use WorkoutPlan's totalDurationMinutes instead of calculating manually
    var totalTime: Int {
        guard currentIndex < DataTrainingModel.shared.trainingPlans.count else { return 0 }
        return DataTrainingModel.shared.trainingPlans[currentIndex].totalDurationMinutes
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.quasePreto
                Image("BackgroundColorfull")
                    .resizable()
                    .scaledToFit( )
                    .offset(y: 150)
                
                VStack(spacing: 48){
                    
                    Spacer()
                    
                    ZStack{
                        Image("DashedRectangle")
                        HStack{
                            Image(systemName: "figure.flexibility")
                            Text("Alongue o corpo todo, sem pressa.")
                        }
                    }
                    .padding(.top, 60)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    
                    //RETANGULO BRANCO
                    VStack(alignment: .leading, spacing: 40){
                        
                        ZStack{
                            HStack{
                                Spacer()
                                
                                ZStack{
                                    Image("Star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90)
                                        .offset(y: -70)
                                    //MUDAR AQUI
                                    Text("\(totalTime)'")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .offset(y: -70)
                                }
                            }
                            
                            //Deep Seek: Updated to show phases grouped by type (warmup vs main)
                            if currentIndex < DataTrainingModel.shared.trainingPlans.count {
                                WorkoutPhasesView(workoutPlan: DataTrainingModel.shared.trainingPlans[currentIndex])
                            }
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    NavigationLink{
                        StretchingView()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Começar a Correr")
                                .padding(.vertical, 12)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(.roxo)
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "arrow.backward")
                                Text("Treino de Hoje")
                            }
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

//Deep Seek: New helper view to display workout phases
struct WorkoutPhasesView: View {
    let workoutPlan: WorkoutPlan
    
    var body: some View {
        VStack(alignment: .leading) {
            //Group warmup phases
            let warmupPhases = workoutPlan.phases.filter { $0.imageAsset.contains("Aquecimento") }
            if !warmupPhases.isEmpty {
                Text("Aquecimento (\(workoutPlan.totalRepetitions)x)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                
                ForEach(warmupPhases) { phase in
                    HStack {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 20))
                            .padding(.trailing, 24)
                        VStack(alignment: .leading) {
                            Text(phase.name)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            Text("\(phase.duration)\"")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 8)
                    Divider()
                }
            }
            
            //Group main training phases
            let trainingPhases = workoutPlan.phases.filter { $0.imageAsset.contains("Treino") }
            if !trainingPhases.isEmpty {
                Text("Treino Principal (\(workoutPlan.totalRepetitions)x)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                
                ForEach(trainingPhases) { phase in
                    HStack {
                        Image(systemName: "figure.run")
                            .font(.system(size: 20))
                            .padding(.trailing, 24)
                        VStack(alignment: .leading) {
                            Text(phase.name)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            Text("\(phase.duration)\"")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 8)
                    Divider()
                }
            }
        }
    }
}

#Preview {
    WorkoutView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
