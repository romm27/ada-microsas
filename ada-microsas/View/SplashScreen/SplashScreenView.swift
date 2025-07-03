//
//  SplashScreenView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 27/06/25.
//

import SwiftUI

public struct SplashScreenView: View {
    public var body: some View {
        ZStack{
            Color.roxo
                .ignoresSafeArea(edges: .all)
            VStack{
                Image("LogoLight")
                    .resizable()
                    .scaledToFit( )
                    .frame(width: 225)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
