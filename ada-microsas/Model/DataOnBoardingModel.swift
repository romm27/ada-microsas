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
            image: "Background01"
        ),
        
        Card(
            image: "Background02"
        ),
        
        Card(
            image: "Background03"
        )
    ]
}
