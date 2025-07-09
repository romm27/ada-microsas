//
//  StopMotion.swift
//  ada-microsas
//
//  Created by Carla Araujo on 08/07/25.
//

import SpriteKit

//ALONGAMENTO
class Stretching: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaAlongamentoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaAlongamentoTexturas.first {
                    belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                    belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                    belezinhaNode.setScale(0.25)
                    addChild(belezinhaNode)

                    animarBelezinha(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaAlongamentoTexturas.append(SKTexture(imageNamed: "alongamento01"))
        belezinhaAlongamentoTexturas.append(SKTexture(imageNamed: "alongamento02"))
        belezinhaAlongamentoTexturas.append(SKTexture(imageNamed: "alongamento03"))
                
        }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaAlongamentoTexturas, timePerFrame: 0.3)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }

}



//POLICHINELO
class Polichinelo: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaPolichineloTexturas01: [SKTexture] = []
    var belezinhaPolichineloTexturas02: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha01()
            carregarTexturasBelezinha02()

        if let primeiraTextura = belezinhaPolichineloTexturas01.first {
            belezinhaNode = SKSpriteNode(texture: primeiraTextura)
            belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
            belezinhaNode.setScale(0.25)
            addChild(belezinhaNode)
//          animarBelezinha(node: belezinhaNode)
            animarSalto(node: belezinhaNode)
                }
        if let primeiraTextura = belezinhaPolichineloTexturas02.first {
            belezinhaNode = SKSpriteNode(texture: primeiraTextura)
            belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
            belezinhaNode.setScale(0.25)
            addChild(belezinhaNode)
//          animarBelezinha(node: belezinhaNode)
            animarSalto(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha01() {
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo01"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo02"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo03"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo04"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo05"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo06"))
        belezinhaPolichineloTexturas01.append(SKTexture(imageNamed: "polichinelo07"))
      }
    
    func carregarTexturasBelezinha02() {
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo06"))
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo05"))
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo04"))
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo03"))
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo02"))
        belezinhaPolichineloTexturas02.append(SKTexture(imageNamed: "polichinelo01"))
        }
    
    func animarSalto(node: SKSpriteNode) {
        let alturaDoSalto: CGFloat = 30.0 // Ajuste este valor para controlar a altura do salto
        let duracaoSubida: TimeInterval = 0.5 // Duração da subida
        let duracaoDescida: TimeInterval = 0.5 // Duração da descida
        
        // Ação para mover para cima
        let moverCima = SKAction.moveBy(x: 0, y: alturaDoSalto, duration: duracaoSubida)
        moverCima.timingMode = .easeOut // Começa rápido, desacelera ao subir
        
        // Ação para mover para baixo
        let moverBaixo = SKAction.moveBy(x: 0, y: -alturaDoSalto, duration: duracaoDescida)
        moverBaixo.timingMode = .easeIn // Começa lento, acelera ao descer
        
        // Sequência de subida e descida
        let sequenciaSalto = SKAction.sequence([moverCima, moverBaixo])
        
        // Ação para a animação das texturas (se houver mais de uma para o salto)
        let animacaoTexturas01 = SKAction.animate(with: belezinhaPolichineloTexturas01, timePerFrame: 0.2) // Ajuste o timePerFrame conforme suas texturas
        let animacaoTexturas02 = SKAction.animate(with: belezinhaPolichineloTexturas02, timePerFrame: 0.2)
        // Agrupar as ações de movimento e textura para que ocorram simultaneamente
        let grupoDeAcoes = SKAction.group([animacaoTexturas01, sequenciaSalto, animacaoTexturas02])
        
        // Repetir a sequência indefinidamente
        let repetirSalto = SKAction.repeatForever(grupoDeAcoes)
        
        node.run(repetirSalto, withKey: "animacaoSalto")
    }
    
//    func animarBelezinha(node: SKSpriteNode) {
//            let animacao = SKAction.animate(with: belezinhaPolichineloTexturas, timePerFrame: 0.07)
//            
//            let repetirAnimacao = SKAction.repeatForever(animacao)
//            
//            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
//        }
//    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//AGACHAMENTO
class Agachamento: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaAgachamentoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaAgachamentoTexturas.first {
                    belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                    belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                    belezinhaNode.setScale(0.25)
                    addChild(belezinhaNode)
                    animarBelezinha(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaAgachamentoTexturas.append(SKTexture(imageNamed: "agachamento01"))
        belezinhaAgachamentoTexturas.append(SKTexture(imageNamed: "agachamento02"))
        }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaAgachamentoTexturas, timePerFrame: 0.5)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//PANTURRILHA
class Panturrilha: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaSaltoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaSaltoTexturas.first {
                belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                belezinhaNode.setScale(0.25)
                addChild(belezinhaNode)
                animarBelezinha(node: belezinhaNode)

                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto01"))
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto02"))
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto03"))
        }
    
//    func animarSalto(node: SKSpriteNode) {
//        let alturaDoSalto: CGFloat = 30.0 // Ajuste este valor para controlar a altura do salto
//        let duracaoSubida: TimeInterval = 0.5 // Duração da subida
//        let duracaoDescida: TimeInterval = 0.5 // Duração da descida
//        
//        // Ação para mover para cima
//        let moverCima = SKAction.moveBy(x: 0, y: alturaDoSalto, duration: duracaoSubida)
//        moverCima.timingMode = .easeOut // Começa rápido, desacelera ao subir
//        
//        // Ação para mover para baixo
//        let moverBaixo = SKAction.moveBy(x: 0, y: -alturaDoSalto, duration: duracaoDescida)
//        moverBaixo.timingMode = .easeIn // Começa lento, acelera ao descer
//        
//        // Sequência de subida e descida
//        let sequenciaSalto = SKAction.sequence([moverCima, moverBaixo])
//        
//        // Ação para a animação das texturas (se houver mais de uma para o salto)
//        let animacaoTexturas = SKAction.animate(with: belezinhaSaltoTexturas, timePerFrame: 0.2) // Ajuste o timePerFrame conforme suas texturas
//        
//        // Agrupar as ações de movimento e textura para que ocorram simultaneamente
//        let grupoDeAcoes = SKAction.group([sequenciaSalto, animacaoTexturas])
//        
//        // Repetir a sequência indefinidamente
//        let repetirSalto = SKAction.repeatForever(grupoDeAcoes)
//        
//        node.run(repetirSalto, withKey: "animacaoSalto")
//    }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaSaltoTexturas, timePerFrame: 0.5)

            let repetirAnimacao = SKAction.repeatForever(animacao)

            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//SALTO
class Salto: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaSaltoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaSaltoTexturas.first {
                belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                belezinhaNode.setScale(0.25)
                addChild(belezinhaNode)
//                animarBelezinha(node: belezinhaNode)
            
                animarSalto(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto01"))
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto02"))
        belezinhaSaltoTexturas.append(SKTexture(imageNamed: "salto03"))
        }
    
    func animarSalto(node: SKSpriteNode) {
        let alturaDoSalto: CGFloat = 30.0 // Ajuste este valor para controlar a altura do salto
        let duracaoSubida: TimeInterval = 0.5 // Duração da subida
        let duracaoDescida: TimeInterval = 0.5 // Duração da descida
        
        // Ação para mover para cima
        let moverCima = SKAction.moveBy(x: 0, y: alturaDoSalto, duration: duracaoSubida)
        moverCima.timingMode = .easeOut // Começa rápido, desacelera ao subir
        
        // Ação para mover para baixo
        let moverBaixo = SKAction.moveBy(x: 0, y: -alturaDoSalto, duration: duracaoDescida)
        moverBaixo.timingMode = .easeIn // Começa lento, acelera ao descer
        
        // Sequência de subida e descida
        let sequenciaSalto = SKAction.sequence([moverCima, moverBaixo])
        
        // Ação para a animação das texturas (se houver mais de uma para o salto)
        let animacaoTexturas = SKAction.animate(with: belezinhaSaltoTexturas, timePerFrame: 0.2) // Ajuste o timePerFrame conforme suas texturas
        
        // Agrupar as ações de movimento e textura para que ocorram simultaneamente
        let grupoDeAcoes = SKAction.group([sequenciaSalto, animacaoTexturas])
        
        // Repetir a sequência indefinidamente
        let repetirSalto = SKAction.repeatForever(grupoDeAcoes)
        
        node.run(repetirSalto, withKey: "animacaoSalto")
    }
    
//    func animarBelezinha(node: SKSpriteNode) {
//            let animacao = SKAction.animate(with: belezinhaSaltoTexturas, timePerFrame: 0.5)
//            
//            let repetirAnimacao = SKAction.repeatForever(animacao)
//            
//            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
//        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//CAMINHAR
class Caminhar: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaCaminharTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaCaminharTexturas.first {
                    belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                    belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                    belezinhaNode.setScale(0.25)
                    addChild(belezinhaNode)
                    animarBelezinha(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar01"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar02"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar03"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar04"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar05"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar06"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar07"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar08"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar09"))
        }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaCaminharTexturas, timePerFrame: 0.1)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}

//CORRIDA
class Corrida: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaCaminharTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            backgroundColor = .clear
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaCaminharTexturas.first {
                    belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                    belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                    belezinhaNode.setScale(0.25)
                    addChild(belezinhaNode)
                    animarBelezinha(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar01"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar02"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar03"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar04"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar05"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar06"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar07"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar08"))
        belezinhaCaminharTexturas.append(SKTexture(imageNamed: "caminhar09"))
        }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaCaminharTexturas, timePerFrame: 0.05)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}

