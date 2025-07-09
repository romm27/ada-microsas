//
//  Test.swift
//  ada-microsas
//
//  Created by Carla Araujo on 08/07/25.
//

import SwiftUI
import SpriteKit

//POLICHINELO
struct TestPolichinelo: View {
    let polichineloScene = Polichinelo()
    var body: some View {
        SpriteView(scene: polichineloScene)
            .frame(width: 200, height: 200)
            .scaledToFit()
            .padding(.leading, 45)
    }
}

//AGACHAMENTO
struct TestAgachamento: View {
    let agachamentoScene = Agachamento()
    var body: some View {
        SpriteView(scene: agachamentoScene)
            .frame(width: 200, height: 200)
            .scaledToFit()
            .padding(.leading, 45)
    }
}

//SALTO
struct TestSalto: View {
    let saltoScene = Salto()
    var body: some View {
        SpriteView(scene: saltoScene)
            .frame(width: 200, height: 200)
            .scaledToFit()
            .padding(.leading, 45)
    }
}

//CAMINHAR
struct TestCaminhar: View {
    let caminharScene = Caminhar()
    var body: some View {
        SpriteView(scene: caminharScene)
            .frame(width: 200, height: 200)
            .scaledToFit()
            .padding(.leading, 45)
    }
}



#Preview {
    TestCaminhar()
}
