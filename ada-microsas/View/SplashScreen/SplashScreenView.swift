//
//  SplashScreenView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 27/06/25.
//

import SwiftUI

public struct SplashScreenView: View {
    public var body: some View {
        VStack{
            Image("SplashScreen")
                .resizable()
                .scaledToFill()
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    SplashScreenView()
}
