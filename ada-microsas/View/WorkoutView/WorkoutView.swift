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
    
    let currentIndex: Int
    
    private var workoutPlan: WorkoutPlan {
        DataTrainingModel.shared.trainingPlans[currentIndex]
    }
    
    var totalTime: Int {
        workoutPlan.totalDurationMinutes
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.quasePreto
                Image("BackgroundColorfull")
                    .resizable()
                    .scaledToFit()
                    .offset(y: 150)
                
                VStack(spacing: 48) {
                    Spacer()
                    
                    // Warmup tip box
                    ZStack {
                        Image("DashedRectangle")
                        HStack {
                            Image(systemName: "figure.flexibility")
                            Text("Alongue o corpo todo, sem pressa.")
                        }
                    }
                    .padding(.top, 60)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    
                    // White content rectangle
                    VStack(alignment: .leading, spacing: 40) {
                        ZStack {
                            HStack {
                                Spacer()
                                ZStack {
                                    Image("Star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90)
                                        .offset(y: -70)
                                    Text("\(totalTime)'")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .offset(y: -70)
                                }
                            }
                            
                            // Workout content
                            VStack(alignment: .leading, spacing: 0) {
                                // Warmup Section
                                if let warmupGroup = workoutPlan.patternGroups.first(where: { $0.isWarmup }) {
                                    Text("Aquecimento (\(warmupGroup.repetitions)x)")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 8)
                                    
                                    ForEach(Array(warmupGroup.phases.filter { !$0.isRest }.enumerated()), id: \.offset) { index, phase in
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
                                        
                                        if index < warmupGroup.phases.filter({ !$0.isRest }).count - 1 {
                                            Divider()
                                        }
                                    }
                                }
                                
                                // Main Training Section
                                if let trainingGroup = workoutPlan.patternGroups.first(where: { !$0.isWarmup }) {
                                    Text("Treino Principal (\(trainingGroup.repetitions)x)")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 8)
                                        .padding(.top, 16)
                                    
                                    ForEach(Array(trainingGroup.phases.filter { !$0.isRest }.enumerated()), id: \.offset) { index, phase in
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
                                        
                                        if index < trainingGroup.phases.filter({ !$0.isRest }).count - 1 {
                                            Divider()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    // Start button
                    NavigationLink {
                        StretchingView()
                    } label: {
                        HStack {
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
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

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(currentIndex: 0)
            .environmentObject(TimerViewModel())
            .environmentObject(PlanViewModel())
    }
}
