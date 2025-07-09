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
            //backgroundColor = .clear
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
    var belezinhaPolichineloTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            //backgroundColor = .cinzaEscuro
            carregarTexturasBelezinha()

        if let primeiraTextura = belezinhaPolichineloTexturas.first {
                    belezinhaNode = SKSpriteNode(texture: primeiraTextura)
                    belezinhaNode.position = CGPoint(x: frame.midX, y: frame.midY)
                    belezinhaNode.setScale(0.25)
                    addChild(belezinhaNode)
                    animarBelezinha(node: belezinhaNode)
                }
        }
    
    func carregarTexturasBelezinha() {
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo01"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo02"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo03"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo04"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo05"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo06"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo07"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo06"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo05"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo04"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo03"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo02"))
        belezinhaPolichineloTexturas.append(SKTexture(imageNamed: "polichinelo01"))
        }
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaPolichineloTexturas, timePerFrame: 0.07)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//AGACHAMENTO
class Agachamento: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaAgachamentoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            //backgroundColor = .cinzaEscuro
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


//SALTO
class Salto: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaSaltoTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            //backgroundColor = .cinzaEscuro
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
    
    func animarBelezinha(node: SKSpriteNode) {
            let animacao = SKAction.animate(with: belezinhaSaltoTexturas, timePerFrame: 0.5)
            
            let repetirAnimacao = SKAction.repeatForever(animacao)
            
            node.run(repetirAnimacao, withKey: "animacaoBelezinha")
        }
    
    override func sceneDidLoad() {
            self.scaleMode = .resizeFill
        }
}


//CAMINHAR
class Caminhar: SKScene{
    var belezinhaNode: SKSpriteNode!
    var belezinhaCaminharTexturas: [SKTexture] = []
    override func didMove(to view: SKView) {
            //backgroundColor = .cinzaEscuro
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

