//
//  Activity.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id: UUID
    
    var order: Int
    var seconds: Int
    var unlocked: Bool
    
    init(id: UUID = UUID(), order: Int, seconds: Int, unlocked: Bool = false) {
        self.id = id
        
        self.order = order
        self.seconds = seconds
        self.unlocked = unlocked
    }
}
