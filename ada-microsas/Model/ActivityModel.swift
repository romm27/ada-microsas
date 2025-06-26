//
//  Activity.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

struct ActivityModel: Identifiable, Codable {
    var id: UUID
    
    var order: Int
    var seconds: Int
    var unlocked: Bool
    var warmingTraining: [String]
    var mainTraining: [String]
    var restTraining: [String]
    var objectiveTraining: String
    
    init(id: UUID = UUID(), order: Int, seconds: Int, unlocked: Bool = false, warmingTraining: [String], mainTraining: [String], restTraining: [String], objectiveTraining: String) {
        self.id = id

        self.order = order
        self.seconds = seconds
        self.unlocked = unlocked
        self.warmingTraining = warmingTraining
        self.mainTraining = mainTraining
        self.restTraining = restTraining
        self.objectiveTraining = objectiveTraining
    }
}
