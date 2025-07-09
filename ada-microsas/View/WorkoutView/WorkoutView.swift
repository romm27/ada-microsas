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
        planViewModel.currentIndex = currentIndex
        return DataTrainingModel.shared.trainingPlans[currentIndex]
    }
    
    var totalTime: Int {
        workoutPlan.totalDurationMinutes
    }
    
    
    
    var body: some View {
        ZStack {
            Color.quasePreto
                .edgesIgnoringSafeArea(.all)
            
            
            Image("BackgroundColorfull")
                .resizable()
                .scaledToFit()
                .offset(y: 150)
                .zIndex(0) // Ensure it stays behind content
            
            VStack(spacing: 48) {
                Spacer()
                
                // Warmup tip box - make sure this is visible
                ZStack {
                    Image("DashedRectangle")
                        .foregroundColor(.white) // Ensure visibility
                    HStack {
                        Image(systemName: "figure.flexibility")
                            .foregroundColor(.white)
                        Text("Alongue o corpo todo, sem pressa.")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 60)
                .font(.system(size: 12, weight: .regular))
                .zIndex(1) // Bring to front
                
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
                                    .offset(y: -120)
                                Text("\(totalTime) min")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(y: -120)
                            }
                        }
                        
                        
                        // Workout content - ensure all text is visible
                        VStack(alignment: .leading, spacing: 0) {
                            // Warmup Section
                            if let warmupGroup = workoutPlan.patternGroups.first(where: { $0.isWarmup }) {
                                Text("Aquecimento (\(warmupGroup.repetitions)x)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black) // Explicit black for white background
                                    .padding(.bottom, 8)
                                
                                ForEach(Array(warmupGroup.phases.filter { !$0.isRest }.enumerated()), id: \.offset) { index, phase in
                                    HStack {
                                        Image(systemName: "figure.walk")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .padding(.trailing, 24)
                                        VStack(alignment: .leading) {
                                            Text(phase.name)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("\(phase.duration)\"")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 8)
                                    
                                    if index < warmupGroup.phases.filter({ !$0.isRest }).count - 1 {
                                        Divider()
                                            .background(Color.gray)
                                    }
                                }
                            }
                            
                            // Main Training Section
                            if let trainingGroup = workoutPlan.patternGroups.first(where: { !$0.isWarmup }) {
                                Text("Treino Principal (\(trainingGroup.repetitions)x)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 8)
                                    .padding(.top, 16)
                                
                                ForEach(Array(trainingGroup.phases.filter { !$0.isRest }.enumerated()), id: \.offset) { index, phase in
                                    HStack {
                                        Image(systemName: "figure.run")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .padding(.trailing, 24)
                                        VStack(alignment: .leading) {
                                            Text(phase.name)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("\(phase.duration)\"")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 8)
                                    
                                    if index < trainingGroup.phases.filter({ !$0.isRest }).count - 1 {
                                        Divider()
                                            .background(Color.gray)
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
                .shadow(radius: 10)
                .zIndex(1) // Ensure it's above background
                
                let buttonEnabled = planViewModel.userLevel >= currentIndex
                
                // Start button
                NavigationLink {
                    StretchingView()
                        .environmentObject(planViewModel)
                        .environmentObject(timerViewModel)
                } label: {
                    HStack {
                        Spacer()
                        if !buttonEnabled {
                            Image(systemName: "lock")
                                .foregroundStyle(.white)
                            
                        }
                        Text(buttonEnabled ? "Começar a Correr" : "Treino Bloqueado")
                            .padding(.vertical, 12)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                    }
                    .background(buttonEnabled ? Color.roxo : Color.cinzaClaro)
                    .cornerRadius(8)
                }
                .zIndex(1)
                .disabled(!buttonEnabled)
                
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
        .preferredColorScheme(.dark)
        .ignoresSafeArea(.all)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(currentIndex: 0)
            .environmentObject(TimerViewModel())
            .environmentObject(PlanViewModel())
    }
}
