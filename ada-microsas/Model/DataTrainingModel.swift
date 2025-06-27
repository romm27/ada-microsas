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
        ActivityModel(
            order: 01,
            seconds: 10,
            warmingTraining: [
                "5 min de corrida leve",
                "5 min de alongamentos (balanços de perna, círculos com o quadril)"
            ],
            mainTraining: [
                "4 × 800 metros em ritmo de prova de 5 km (esforço de 80–85%), com 2 minutos de caminhada ou trote para recuperação"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em panturrilhas, quadríceps, posteriores de coxa e quadris"
            ],
            objectiveTraining: "Resistência de velocidade e eficiência na corrida.",
            requiredLevel: 1
        ),
        
        // treino 02
        ActivityModel(
            order: 02,
            seconds: 15,
            warmingTraining: [
                "10 minutos de trote leve",
                "5 minutos de mobilidade (círculos de tornozelo, rotação de joelhos e quadril)"
            ],
            mainTraining: [
                "6 × 400 metros em ritmo um pouco mais rápido que o de 5 km, com 1 minuto de caminhada entre as repetições"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento suave de panturrilhas e quadris"
            ],
            objectiveTraining: "Aumentar a velocidade e a resistência em distâncias curtas.",
            requiredLevel: 2
        ),

        // treino 03
        ActivityModel(
            order: 03,
            seconds: 10,
            warmingTraining: [
                "5 minutos de corrida leve",
                "5 minutos de alongamentos dinâmicos (skiping, polichinelos, avanço com rotação)"
            ],
            mainTraining: [
                "3 × 1 km em ritmo de prova de 10 km, com 3 minutos de descanso ativo (caminhada ou trote)"
            ],
            restTraining: ["5 minutos de trote leve", "Alongamento com foco em posteriores e quadríceps"],
            objectiveTraining: "Melhorar a capacidade aeróbica e o ritmo sustentado.",
            requiredLevel: 3
        ),

        // treino 04
        ActivityModel(
            order: 04,
            seconds: 10,
            warmingTraining: [
                "8 minutos de corrida leve",
                "2 minutos de exercícios de mobilidade articular"
            ],
            mainTraining: [
                "10 × 200 metros em ritmo forte, com 1 minuto de descanso entre cada repetição"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em quadril, glúteos e panturrilhas"
            ],
            objectiveTraining: "Desenvolver explosão e agilidade.",
            requiredLevel: 4
        ),

        // treino 05
        ActivityModel(
            order: 05,
            seconds: 10,
            warmingTraining: [
                "5 minutos de trote leve",
                "5 minutos de aquecimento dinâmico com foco em amplitude de movimento"
            ],
            mainTraining: [
                "4 × 1.200 metros em ritmo moderado (70–80%), com 2 a 3 minutos de recuperação ativa"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento focado em quadríceps, posteriores e lombar"
            ],
            objectiveTraining: "Aprimorar resistência aeróbica e controle do ritmo.",
            requiredLevel: 5
        ),

        // treino 06
        ActivityModel(
            order: 06,
            seconds: 10,
            warmingTraining: [
                "6 minutos de corrida leve",
                "4 minutos de exercícios de técnica de corrida (joelho alto, calcanhar no glúteo, passadas curtas)"
            ],
            mainTraining: [
                "Fartlek: 1 min forte + 2 min leve × 6 repetições"
            ],
            restTraining: [
                "5 minutos de trote leve",
                "Alongamentos com foco em relaxamento muscular geral"
            ],
            objectiveTraining: "Melhorar variações de ritmo e adaptação cardiovascular.",
            requiredLevel: 6
        ),
        
        
        
        
        
        
        
        //COPIAS PARA TESTE AAAAAAA
        //treino 01
        ActivityModel(
            order: 07,
            seconds: 10,
            warmingTraining: [
                "5 min de corrida leve",
                "5 min de alongamentos (balanços de perna, círculos com o quadril)"
            ],
            mainTraining: [
                "4 × 800 metros em ritmo de prova de 5 km (esforço de 80–85%), com 2 minutos de caminhada ou trote para recuperação"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em panturrilhas, quadríceps, posteriores de coxa e quadris"
            ],
            objectiveTraining: "Resistência de velocidade e eficiência na corrida.",
            requiredLevel: 7
        ),
        
        // treino 02
        ActivityModel(
            order: 08,
            seconds: 10,
            warmingTraining: [
                "10 minutos de trote leve",
                "5 minutos de mobilidade (círculos de tornozelo, rotação de joelhos e quadril)"
            ],
            mainTraining: [
                "6 × 400 metros em ritmo um pouco mais rápido que o de 5 km, com 1 minuto de caminhada entre as repetições"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento suave de panturrilhas e quadris"
            ],
            objectiveTraining: "Aumentar a velocidade e a resistência em distâncias curtas.",
            requiredLevel: 8
        ),

        // treino 03
        ActivityModel(
            order: 09,
            seconds: 10,
            warmingTraining: [
                "5 minutos de corrida leve",
                "5 minutos de alongamentos dinâmicos (skiping, polichinelos, avanço com rotação)"
            ],
            mainTraining: [
                "3 × 1 km em ritmo de prova de 10 km, com 3 minutos de descanso ativo (caminhada ou trote)"
            ],
            restTraining: ["5 minutos de trote leve", "Alongamento com foco em posteriores e quadríceps"],
            objectiveTraining: "Melhorar a capacidade aeróbica e o ritmo sustentado.",
            requiredLevel: 9
        ),

        // treino 04
        ActivityModel(
            order: 10,
            seconds: 10,
            warmingTraining: [
                "8 minutos de corrida leve",
                "2 minutos de exercícios de mobilidade articular"
            ],
            mainTraining: [
                "10 × 200 metros em ritmo forte, com 1 minuto de descanso entre cada repetição"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em quadril, glúteos e panturrilhas"
            ],
            objectiveTraining: "Desenvolver explosão e agilidade.",
            requiredLevel: 10
        ),

        // treino 05
        ActivityModel(
            order: 11,
            seconds: 10,
            warmingTraining: [
                "5 minutos de trote leve",
                "5 minutos de aquecimento dinâmico com foco em amplitude de movimento"
            ],
            mainTraining: [
                "4 × 1.200 metros em ritmo moderado (70–80%), com 2 a 3 minutos de recuperação ativa"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento focado em quadríceps, posteriores e lombar"
            ],
            objectiveTraining: "Aprimorar resistência aeróbica e controle do ritmo.",
            requiredLevel: 11
        ),

        // treino 06
        ActivityModel(
            order: 12,
            seconds: 10,
            warmingTraining: [
                "6 minutos de corrida leve",
                "4 minutos de exercícios de técnica de corrida (joelho alto, calcanhar no glúteo, passadas curtas)"
            ],
            mainTraining: [
                "Fartlek: 1 min forte + 2 min leve × 6 repetições"
            ],
            restTraining: [
                "5 minutos de trote leve",
                "Alongamentos com foco em relaxamento muscular geral"
            ],
            objectiveTraining: "Melhorar variações de ritmo e adaptação cardiovascular.",
            requiredLevel: 12
        ),
        //treino 01
        ActivityModel(
            order: 13,
            seconds: 10,
            warmingTraining: [
                "5 min de corrida leve",
                "5 min de alongamentos (balanços de perna, círculos com o quadril)"
            ],
            mainTraining: [
                "4 × 800 metros em ritmo de prova de 5 km (esforço de 80–85%), com 2 minutos de caminhada ou trote para recuperação"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em panturrilhas, quadríceps, posteriores de coxa e quadris"
            ],
            objectiveTraining: "Resistência de velocidade e eficiência na corrida.",
            requiredLevel: 13
        ),
        
        // treino 02
        ActivityModel(
            order: 14,
            seconds: 10,
            warmingTraining: [
                "10 minutos de trote leve",
                "5 minutos de mobilidade (círculos de tornozelo, rotação de joelhos e quadril)"
            ],
            mainTraining: [
                "6 × 400 metros em ritmo um pouco mais rápido que o de 5 km, com 1 minuto de caminhada entre as repetições"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento suave de panturrilhas e quadris"
            ],
            objectiveTraining: "Aumentar a velocidade e a resistência em distâncias curtas.",
            requiredLevel: 14
        ),

        // treino 03
        ActivityModel(
            order: 15,
            seconds: 10,
            warmingTraining: [
                "5 minutos de corrida leve",
                "5 minutos de alongamentos dinâmicos (skiping, polichinelos, avanço com rotação)"
            ],
            mainTraining: [
                "3 × 1 km em ritmo de prova de 10 km, com 3 minutos de descanso ativo (caminhada ou trote)"
            ],
            restTraining: ["5 minutos de trote leve", "Alongamento com foco em posteriores e quadríceps"],
            objectiveTraining: "Melhorar a capacidade aeróbica e o ritmo sustentado.",
            requiredLevel: 15
        ),

        // treino 04
        ActivityModel(
            order: 16,
            seconds: 10,
            warmingTraining: [
                "8 minutos de corrida leve",
                "2 minutos de exercícios de mobilidade articular"
            ],
            mainTraining: [
                "10 × 200 metros em ritmo forte, com 1 minuto de descanso entre cada repetição"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em quadril, glúteos e panturrilhas"
            ],
            objectiveTraining: "Desenvolver explosão e agilidade.",
            requiredLevel: 16
        ),

        // treino 05
        ActivityModel(
            order: 17,
            seconds: 10,
            warmingTraining: [
                "5 minutos de trote leve",
                "5 minutos de aquecimento dinâmico com foco em amplitude de movimento"
            ],
            mainTraining: [
                "4 × 1.200 metros em ritmo moderado (70–80%), com 2 a 3 minutos de recuperação ativa"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento focado em quadríceps, posteriores e lombar"
            ],
            objectiveTraining: "Aprimorar resistência aeróbica e controle do ritmo.",
            requiredLevel: 17
        ),

        // treino 06
        ActivityModel(
            order: 18,
            seconds: 10,
            warmingTraining: [
                "6 minutos de corrida leve",
                "4 minutos de exercícios de técnica de corrida (joelho alto, calcanhar no glúteo, passadas curtas)"
            ],
            mainTraining: [
                "Fartlek: 1 min forte + 2 min leve × 6 repetições"
            ],
            restTraining: [
                "5 minutos de trote leve",
                "Alongamentos com foco em relaxamento muscular geral"
            ],
            objectiveTraining: "Melhorar variações de ritmo e adaptação cardiovascular.",
            requiredLevel: 18
        ),
        //treino 01
        ActivityModel(
            order: 19,
            seconds: 10,
            warmingTraining: [
                "5 min de corrida leve",
                "5 min de alongamentos (balanços de perna, círculos com o quadril)"
            ],
            mainTraining: [
                "4 × 800 metros em ritmo de prova de 5 km (esforço de 80–85%), com 2 minutos de caminhada ou trote para recuperação"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em panturrilhas, quadríceps, posteriores de coxa e quadris"
            ],
            objectiveTraining: "Resistência de velocidade e eficiência na corrida.",
            requiredLevel: 19
        ),
        
        // treino 02
        ActivityModel(
            order: 20,
            seconds: 10,
            warmingTraining: [
                "10 minutos de trote leve",
                "5 minutos de mobilidade (círculos de tornozelo, rotação de joelhos e quadril)"
            ],
            mainTraining: [
                "6 × 400 metros em ritmo um pouco mais rápido que o de 5 km, com 1 minuto de caminhada entre as repetições"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento suave de panturrilhas e quadris"
            ],
            objectiveTraining: "Aumentar a velocidade e a resistência em distâncias curtas.",
            requiredLevel: 20
        ),

        // treino 03
        ActivityModel(
            order: 21,
            seconds: 10,
            warmingTraining: [
                "5 minutos de corrida leve",
                "5 minutos de alongamentos dinâmicos (skiping, polichinelos, avanço com rotação)"
            ],
            mainTraining: [
                "3 × 1 km em ritmo de prova de 10 km, com 3 minutos de descanso ativo (caminhada ou trote)"
            ],
            restTraining: ["5 minutos de trote leve", "Alongamento com foco em posteriores e quadríceps"],
            objectiveTraining: "Melhorar a capacidade aeróbica e o ritmo sustentado.",
            requiredLevel: 21
        ),

        // treino 04
        ActivityModel(
            order: 22,
            seconds: 10,
            warmingTraining: [
                "8 minutos de corrida leve",
                "2 minutos de exercícios de mobilidade articular"
            ],
            mainTraining: [
                "10 × 200 metros em ritmo forte, com 1 minuto de descanso entre cada repetição"
            ],
            restTraining: [
                "5 a 10 minutos de corrida leve",
                "Alongamento leve focado em quadril, glúteos e panturrilhas"
            ],
            objectiveTraining: "Desenvolver explosão e agilidade.",
            requiredLevel: 22
        ),

        // treino 05
        ActivityModel(
            order: 23,
            seconds: 10,
            warmingTraining: [
                "5 minutos de trote leve",
                "5 minutos de aquecimento dinâmico com foco em amplitude de movimento"
            ],
            mainTraining: [
                "4 × 1.200 metros em ritmo moderado (70–80%), com 2 a 3 minutos de recuperação ativa"
            ],
            restTraining: [
                "5 minutos de caminhada",
                "Alongamento focado em quadríceps, posteriores e lombar"
            ],
            objectiveTraining: "Aprimorar resistência aeróbica e controle do ritmo.",
            requiredLevel: 23
        ),

        // treino 06
        ActivityModel(
            order: 24,
            seconds: 10,
            warmingTraining: [
                "6 minutos de corrida leve",
                "4 minutos de exercícios de técnica de corrida (joelho alto, calcanhar no glúteo, passadas curtas)"
            ],
            mainTraining: [
                "Fartlek: 1 min forte + 2 min leve × 6 repetições"
            ],
            restTraining: [
                "5 minutos de trote leve",
                "Alongamentos com foco em relaxamento muscular geral"
            ],
            objectiveTraining: "Melhorar variações de ritmo e adaptação cardiovascular.",
            requiredLevel: 24
        )

     
        
    ]
    
}
