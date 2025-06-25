//
//  PlanViewModel.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    //A Planilha com todos os dias, populada manualmente com as infos dos treinos
    private var planPopulate: [Activity] = [
        Activity(order: 1, seconds: 60 * 4, unlocked: true),
        Activity(order: 2, seconds: 60 * 4),
        Activity(order: 3, seconds: 60 * 4),
        Activity(order: 4, seconds: 60 * 4),
        Activity(order: 5, seconds: 60 * 4),
        Activity(order: 6, seconds: 60 * 4)
    ]
    
    //A planilha do Usuário - essa é a nossa "fonte de verdade"
    @Published var userPlan: [Activity] = [] {
        
        didSet {
            //Salva a planilha sempre que alguma coisa é atualizada
            savePlan()
        }
    }
    
    init () {
        //Carrega a planilha sempre que abre o app
        loadPlan()
    }
    
    func savePlan() {
        //TODO: Lógica de Salvar no Celular
    }
    
    func loadPlan() {
        //TODO: Lógica de Load no Celular
    }
    
    func markDayAsDone(at index: Int) {
        userPlan[index].unlocked = true
    }
    
    
    
    
    
}
