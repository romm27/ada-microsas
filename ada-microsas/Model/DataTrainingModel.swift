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
        duration: 15,
        isRest: true,
        imageAsset: "BelezinhaDescanso"
    )
    
    static let debugWorkoutPlan: WorkoutPlan = WorkoutPlan(
        phases: [
            ActivityPhase(
                name: "Polichinelo",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaAquecimento"
            ),
            restActivityPhase,
            ActivityPhase(
                name: "Salto na Ponta do Pé",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaAquecimento"
            ),
            restActivityPhase,
            ActivityPhase(
                name: "Corrida Parada",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaAquecimento"
            ),
            restActivityPhase,
            ActivityPhase(
                name: "Trote",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaTreino"
            ),
            ActivityPhase(
                name: "Corrida",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaTreino"
            ),
            restActivityPhase,
            ActivityPhase(
                name: "Trote",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaTreino"
            ),
            ActivityPhase(
                name: "Caminhada",
                duration: 15,
                isRest: false,
                imageAsset: "BelezinhaTreino"
            ),
        ],
        totalRepetitions: 2,
        requiredLevel: 1
    )
    
    //Transformar em let na segunda
    var trainingPlans: [WorkoutPlan] = [
        
    ]
    
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

struct WorkoutPlan: Identifiable {
    let id = UUID()
    let phases: [ActivityPhase]
    let totalRepetitions: Int
    let requiredLevel: Int
    
    var totalDurationMinutes: Int {
        (phases.reduce(0) { $0 + $1.duration } * totalRepetitions) / 60
    }
}
