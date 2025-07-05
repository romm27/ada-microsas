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
                    
                    WarmupTipView()
                    
                    // White content rectangle
                    VStack(alignment: .leading, spacing: 40) {
                        WorkoutHeaderView(totalTime: totalTime)
                        
                        // Display all pattern groups
                        ForEach(workoutPlan.patternGroups) { group in
                            PatternGroupView(group: group)
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    StartWorkoutButton()
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton()
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

// MARK: - Subviews

private struct WarmupTipView: View {
    var body: some View {
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
    }
}

private struct WorkoutHeaderView: View {
    let totalTime: Int
    
    var body: some View {
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
        }
    }
}

private struct PatternGroupView: View {
    let group: PatternGroup
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(groupTitle)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            
            ForEach(group.phases) { phase in
                if !phase.isRest { // Skip rest phases in the overview
                    ActivityRow(phase: phase, isWarmup: group.isWarmup)
                    Divider()
                }
            }
        }
    }
    
    private var groupTitle: String {
        group.isWarmup ?
        "Aquecimento (\(group.repetitions)x)" :
        "Treino Principal (\(group.repetitions)x)"
    }
}

private struct ActivityRow: View {
    let phase: ActivityPhase
    let isWarmup: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isWarmup ? "figure.walk" : "figure.run")
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
    }
}

private struct StartWorkoutButton: View {
    var body: some View {
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
    }
}

private struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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

#Preview {
    WorkoutView(currentIndex: 0)
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
