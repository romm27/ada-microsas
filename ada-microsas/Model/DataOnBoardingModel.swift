//
//  DataOnBoardingModel.swift
//  ada-microsas
//
//  Created by Carla Araujo on 05/07/25.
//

import Foundation

struct Card: Identifiable{
    let id = UUID()
    let image: String
}


struct DataOnBoardingModel{
    let cardsList: [Card] = [
        Card(
            image: "ob01"
        ),
        
        Card(
            image: "ob02"
        ),
        
        Card(
            image: "ob03"
        ),
        
        Card(
            image: "na01"
        ),
        
        Card(
            image: "na02"
        ),
        
        Card(
            image: "na03"
        )
    ]
}
