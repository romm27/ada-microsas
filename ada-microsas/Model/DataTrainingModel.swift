//
//  DataTrainingModel.swift
//  ada-microsas
//
//  Created by Carla Araujo on 26/06/25.
//

import Foundation

struct DataTrainingModel{
    
    static let shared = DataTrainingModel()
    
    let trainingList: [ActivityModel] = [
        
        //treino 01
//        ActivityModel(
//            order: 01,
//            seconds: 10,
//            warmingTraining: [
//                "5 min de corrida leve",
//                "5 min de alongamentos (balanços de perna, círculos com o quadril)"
//            ],
//            mainTraining: [
//                "4 × 800 metros em ritmo de prova de 5 km (esforço de 80–85%), com 2 minutos de caminhada ou trote para recuperação"
//            ],
//            restTraining: [
//                "5 a 10 minutos de corrida leve",
//                "Alongamento leve focado em panturrilhas, quadríceps, posteriores de coxa e quadris"
//            ],
//            objectiveTraining: "Resistência de velocidade e eficiência na corrida.",
//            requiredLevel: 1,
//            warmingUp: [30, 50, 30]
//        )
        
        //ATIVIDADE FAKE
         ActivityModel(
            order: 01,
            warmingUp: [15, 15, 15],
            warmingUpCount: 2,
            warmUpRest: [5, 5, 5],
            mainTraining: [5, 5],
            mainTrainingCount: 6,
            requiredLevel: 1,
        ),
         //treino 02
          ActivityModel(
             order: 02,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 2,
         ),
         //treino 03
          ActivityModel(
             order: 03,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 3,
         ),
         //treino 03
          ActivityModel(
             order: 04,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 3],
             mainTrainingCount: 6,
             requiredLevel: 4,
         ),
         //treino 03
          ActivityModel(
             order: 05,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 5,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         ),
         //treino 03
          ActivityModel(
             order: 06,
             warmingUp: [30, 30, 30, 30, 30, 30],
             warmingUpCount: 2,
             warmUpRest: [30, 30, 30],
             mainTraining: [30, 180],
             mainTrainingCount: 6,
             requiredLevel: 6,
         )
    ]
}
