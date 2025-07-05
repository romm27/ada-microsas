//
//  DataTrainingModel.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import Foundation

struct DataTrainingModel {
    static let shared = DataTrainingModel()
    
    //DEBUG TOSCO D++++ REAVALIAR SEGUNDA!
    static let restActivityPhase: ActivityPhase = ActivityPhase(
        name: "Descanso",
        duration: 3,
        isRest: true,
        imageAsset: "BelezinhaDescanso"
    )
    
    static let debugWorkoutPlan: WorkoutPlan = WorkoutPlan(
        patternGroups: [
            PatternGroup(
                repetitions: 2,
                isWarmup: true,
                phases: [
                    ActivityPhase(
                        name: "Polichinelo",
                        duration: 3,
                        isRest: false,
                        imageAsset: "BelezinhaAquecimento"
                    ),
                    restActivityPhase,
                    ActivityPhase(
                        name: "Salto na Ponta do Pé",
                        duration: 3,
                        isRest: false,
                        imageAsset: "BelezinhaAquecimento"
                    ),
                    restActivityPhase,
                    ActivityPhase(
                        name: "Correr Parado",
                        duration: 3,
                        isRest: false,
                        imageAsset: "BelezinhaAquecimento"
                    ),
                    restActivityPhase
                ]
            ),
            
            // Main training group (repeats 2 times)
            PatternGroup(
                repetitions: 2,
                isWarmup: false,
                phases: [
                    ActivityPhase(
                        name: "Trote",
                        duration: 3,
                        isRest: false,
                        imageAsset: "BelezinhaTreino"
                    ),
                    ActivityPhase(
                        name: "Corrida",
                        duration: 3,
                        isRest: false,
                        imageAsset: "BelezinhaTreino"
                    )
                ]
            )
        ],
        requiredLevel: 1
    )
    
    var trainingPlans: [WorkoutPlan] = []
    
    init() {
        for _ in 1...24 {
            trainingPlans.append(DataTrainingModel.debugWorkoutPlan)
        }
    }
}

struct ActivityPhase: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int
    let isRest: Bool
    let imageAsset: String
}

struct PatternGroup: Identifiable {
    let id = UUID()
    let repetitions: Int
    let isWarmup: Bool
    let phases: [ActivityPhase]
    
    var totalDuration: Int {
        phases.reduce(0) { $0 + $1.duration } * repetitions
    }
}

struct WorkoutPlan: Identifiable {
    let id = UUID()
    let patternGroups: [PatternGroup]
    let requiredLevel: Int
    
    var totalDurationMinutes: Int {
        patternGroups.reduce(0) { $0 + $1.totalDuration } / 60
    }
    
    var allPhases: [ActivityPhase] {
        patternGroups.flatMap { group in
            Array(repeating: group.phases, count: group.repetitions).flatMap { $0 }
        }
    }
}
