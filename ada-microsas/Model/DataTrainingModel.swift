//
//  DataTrainingModel.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import Foundation
import SpriteKit

struct DataTrainingModel {
    static let shared = DataTrainingModel()

    
    // Warmup Exercises
    static let polichinelo30s = ActivityPhase(name: "Polichinelo", duration: 30, isRest: false, imageAsset: "BelezinhaAquecimento", spriteKitSceneType: Polichinelo.self)
    static let saltoPontaPe30s = ActivityPhase(name: "Salto na Ponta do Pé", duration: 30, isRest: false, imageAsset: "BelezinhaAquecimento", spriteKitSceneType: Salto.self)
    static let corridaParada30s = ActivityPhase(name: "Corrida Parada", duration: 30, isRest: false, imageAsset: "BelezinhaAquecimento", spriteKitSceneType: Caminhar.self)
    static let agachamento30s = ActivityPhase(name: "Agachamento", duration: 30, isRest: false, imageAsset: "BelezinhaAquecimento", spriteKitSceneType: Agachamento.self)
    static let panturrilha30s = ActivityPhase(name: "Panturrilha em Pé", duration: 30, isRest: false, imageAsset: "BelezinhaAquecimento", spriteKitSceneType: Salto.self)

    // Main Training Exercises
    static func trotando(duration: Int) -> ActivityPhase {
        ActivityPhase(name: "Trotando", duration: duration, isRest: false, imageAsset: "BelezinhaTreino", spriteKitSceneType: Caminhar.self)
    }
    
    static func caminhando(duration: Int) -> ActivityPhase {
        ActivityPhase(name: "Caminhando", duration: duration, isRest: false, imageAsset: "BelezinhaDescanso", spriteKitSceneType: Caminhar.self)
    }
    
    // Rest Phases
    static let rest30s = ActivityPhase(name: "Recuperando", duration: 30, isRest: true, imageAsset: "BelezinhaDescanso")
    static let rest60s = ActivityPhase(name: "Recuperando", duration: 60, isRest: true, imageAsset: "BelezinhaDescanso")
    static func parado(duration: Int) -> ActivityPhase {
        ActivityPhase(name: "Recuperação Parado", duration: duration, isRest: true, imageAsset: "BelezinhaDescanso")
    }

    // MARK: - Reusable Pattern Groups (Warmups)

    static let standardWarmup = PatternGroup(
        repetitions: 2,
        isWarmup: true,
        phases: [polichinelo30s, rest30s, saltoPontaPe30s, rest30s, corridaParada30s, rest30s]
    )
    
    static let advancedWarmup = PatternGroup(
        repetitions: 2,
        isWarmup: true,
        phases: [agachamento30s, rest30s, polichinelo30s, rest30s, saltoPontaPe30s, rest30s, corridaParada30s, rest30s, panturrilha30s, rest60s]
    )
    
    static let devWarmup = PatternGroup(
        repetitions: 1,
        isWarmup: true,
        phases: [polichinelo30s, rest30s]
    )
    
    // MARK: - Main Data Source
    
    var trainingPlans: [WorkoutPlan] = []
    
    init() {
        trainingPlans = [
            // TREINO TESTE - DEV MODE
            WorkoutPlan(patternGroups: [
                Self.devWarmup,
                PatternGroup(repetitions: 1, isWarmup: false, phases: [Self.trotando(duration: 5), Self.caminhando(duration: 5)])
            ], requiredLevel: 1),
            
            // TREINO 1
//            WorkoutPlan(patternGroups: [
//                Self.standardWarmup,
//                PatternGroup(repetitions: 6, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 180)])
//            ], requiredLevel: 1),
            
            // TREINO 2
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 4, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 120)])
            ], requiredLevel: 2),
            
            // TREINO 3
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 10, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 90)])
            ], requiredLevel: 3),
            
            // TREINO 4
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 60), Self.caminhando(duration: 180)])
            ], requiredLevel: 4),

            // TREINO 5
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 6, isWarmup: false, phases: [Self.trotando(duration: 60), Self.caminhando(duration: 180)])
            ], requiredLevel: 5),

            // TREINO 6
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 16, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 60)])
            ], requiredLevel: 6),
            
            // TREINO 7
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 7, isWarmup: false, phases: [Self.trotando(duration: 60), Self.caminhando(duration: 120)])
            ], requiredLevel: 7),
            
            // TREINO 8
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 8, isWarmup: false, phases: [Self.trotando(duration: 60), Self.caminhando(duration: 120)])
            ], requiredLevel: 8),

            // TREINO 9
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 8, isWarmup: false, phases: [Self.trotando(duration: 60), Self.caminhando(duration: 180)])
            ], requiredLevel: 9),

            // TREINO 10
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 12, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 30)])
            ], requiredLevel: 10),

            // TREINO 11
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 15, isWarmup: false, phases: [Self.trotando(duration: 30), Self.caminhando(duration: 30)])
            ], requiredLevel: 11),

            // TREINO 12
            WorkoutPlan(patternGroups: [
                Self.standardWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 90), Self.caminhando(duration: 150)])
            ], requiredLevel: 12),

            // TREINO 13
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 7, isWarmup: false, phases: [Self.trotando(duration: 90), Self.caminhando(duration: 150)])
            ], requiredLevel: 13),

            // TREINO 14
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 4, isWarmup: false, phases: [Self.trotando(duration: 90), Self.caminhando(duration: 120)])
            ], requiredLevel: 14),

            // TREINO 15
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 90), Self.caminhando(duration: 120)])
            ], requiredLevel: 15),

            // TREINO 16
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 120), Self.caminhando(duration: 240)])
            ], requiredLevel: 16),

            // TREINO 17
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 6, isWarmup: false, phases: [Self.trotando(duration: 120), Self.caminhando(duration: 240)])
            ], requiredLevel: 17),

            // TREINO 18
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 6, isWarmup: false, phases: [Self.trotando(duration: 120), Self.caminhando(duration: 180)])
            ], requiredLevel: 18),

            // TREINO 19
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 180), Self.parado(duration: 180)])
            ], requiredLevel: 19),

            // TREINO 20
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 180), Self.parado(duration: 120)])
            ], requiredLevel: 20),
            
            // TREINO 21
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 7, isWarmup: false, phases: [Self.trotando(duration: 180), Self.parado(duration: 120)])
            ], requiredLevel: 21),
            
            // TREINO 22
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 180), Self.caminhando(duration: 180)])
            ], requiredLevel: 22),
            
            // TREINO 23
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 3, isWarmup: false, phases: [Self.trotando(duration: 240), Self.caminhando(duration: 180)])
            ], requiredLevel: 23),
            
            // TREINO 24
            WorkoutPlan(patternGroups: [
                Self.advancedWarmup,
                PatternGroup(repetitions: 5, isWarmup: false, phases: [Self.trotando(duration: 240), Self.caminhando(duration: 180)])
            ], requiredLevel: 24),
        ]
    }
}

struct ActivityPhase: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int // Duration in seconds
    let isRest: Bool
    let imageAsset: String
    let spriteKitSceneType: SKScene.Type?
    
    init(name: String, duration: Int, isRest: Bool, imageAsset: String, spriteKitSceneType: SKScene.Type? = nil) {
            self.name = name
            self.duration = duration
            self.isRest = isRest
            self.imageAsset = imageAsset
            self.spriteKitSceneType = spriteKitSceneType
        }
}

struct PatternGroup: Identifiable {
    let id = UUID()
    let repetitions: Int
    let isWarmup: Bool
    let phases: [ActivityPhase]
    
    var totalDuration: Int {
        let singleRepDuration = phases.reduce(0) { $0 + $1.duration }
        return singleRepDuration * repetitions
    }
}

struct WorkoutPlan: Identifiable {
    let id = UUID()
    let patternGroups: [PatternGroup]
    let requiredLevel: Int
    
    var totalDurationMinutes: Int {
        let totalSeconds = patternGroups.reduce(0) { $0 + $1.totalDuration }
        return totalSeconds / 60
    }
    
    var allPhases: [ActivityPhase] {
        patternGroups.flatMap { group in
            Array(repeating: group.phases, count: group.repetitions).flatMap { $0 }
        }
    }
}
