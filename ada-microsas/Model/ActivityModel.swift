//
//  Activity.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

struct ActivityModel: Identifiable {
    var id: UUID
    
    var order: Int
    var unlocked: Bool
    
    var warmingUp: Warming

    var mainTraining: MainTraining
    
    var requiredLevel: Int

    init(id: UUID = UUID(), order: Int, unlocked: Bool = false, warmingUp: [Int], warmingUpCount: Int, mainTraining: [Int], mainTrainingCount: Int, requiredLevel: Int, ) {
        self.id = id

        self.order = order
        self.unlocked = unlocked
        
        self.warmingUp = Warming(timeWarmUp: warmingUp, warmUpCount: warmingUpCount)
        
        self.mainTraining = MainTraining(timeMainTraining: mainTraining, mainTrainingCount: mainTrainingCount)
    
        self.requiredLevel = requiredLevel
    }
}

struct Warming: Identifiable{
    let id = UUID()
    
    static let warmUp: [String] = ["Polichinelo", "Salto na Ponta do Pé", "Corrida Parada"]
    
    //polichinelo, recuperando, salto na ponta do pe, recuperando, corrida parada, recuperando
    
    let timeWarmUp: [Int]
    let warmUpCount: Int
    //tempo de cada atividade do aquecimento
}

struct MainTraining: Identifiable{
    let id = UUID()
    
    static let mainTraining: [String] = ["Trotando", "Caminhando"]
    
    let timeMainTraining: [Int]
    let mainTrainingCount: Int
}



