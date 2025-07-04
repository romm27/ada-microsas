//
//  PlanViewModel.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    //A Planilha com todos os dias, populada manualmente com as infos dos treinos
//    private var planPopulate: [ActivityModel] = [
//        ActivityModel(order: 1, seconds: 60 * 4, unlocked: true),
//        ActivityModel(order: 2, seconds: 60 * 4),
//        ActivityModel(order: 3, seconds: 60 * 4),
//        ActivityModel(order: 4, seconds: 60 * 4),
//        ActivityModel(order: 5, seconds: 60 * 4),
//        ActivityModel(order: 6, seconds: 60 * 4)
//    ]
    
    //A planilha do Usuário - essa é a nossa "fonte de verdade"
//    @Published var userPlan: [ActivityModel] = [] {
//        
//        didSet {
//            //Salva a planilha sempre que alguma coisa é atualizada
//            savePlan()
//        }
//    }

    
    @Published var userLevel: Int = 0 { //Começa em 0 por causa do array, ao mostrar para o jogador adicione + 1.
        //Por exemplo o workout do userLevel 0 é igual ao PRIMEIRO workout(1) para o jogador.
        didSet{
            savePlan()
        }
    }
    
    // Nome do arquivo onde salvaremos os dados
    private let saveKey = "userLevelData.json"
    
    init () {
        //Carrega a planilha sempre que abre o app
        loadPlan()
    }
    
    // Função para obter o caminho do arquivo no diretório de documentos do app
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePlan() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(saveKey)
        
        do {
            // Usamos JSONEncoder para converter nosso Int para o formato Data (JSON)
            let data = try JSONEncoder().encode(userLevel)
            // Escrevemos os dados no arquivo
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            print("Level salvo com sucesso!")
        } catch {
            print("Não foi possível salvar os hábitos: \(error.localizedDescription)")
        }
    }
    
    func loadPlan() {
        
        let fileURL = getDocumentsDirectory().appendingPathComponent(saveKey)
        
        do {
            let data = try Data(contentsOf: fileURL)
            // Usamos JSONDecoder para converter os dados do arquivo de volta para um Int
            let decodedLevel = try JSONDecoder().decode(Int.self, from: data)
            self.userLevel = decodedLevel
            print(userLevel)
            print("Level carregado com sucesso!")
        } catch {
            // Se der erro (ex: arquivo não existe na primeira vez),
            // começamos no level.
            print("Não foi possível carregar o level: \(error.localizedDescription). Começando no level 1.")
            self.userLevel = 0
        }
    }
    
    func setLevel(_ level: Int) {
        self.userLevel = level
    }
    
//    func markDayAsDone(at index: Int) {
//        userPlan[index].unlocked = true
//    }
    
    
    
    
    
}
