//
//  ProfileView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 03/07/25.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("BackgroundColorfull")
                    .resizable()
                    .scaledToFit( )
                    .rotationEffect(.degrees(180))
                    .offset(y: -100)
                
                
                VStack{
                  
                        Image("AvatarCareca")
                            .resizable()
                            .scaledToFit( )
                            .frame(width: 130)
                            .clipShape(Circle()) // Recorta a imagem em forma de círculo
                                .overlay(
                                    Circle().stroke(.roxoBotaoBorda, lineWidth: 8)
                                )
                            
                    
                    
                    //retangulo branco
                    VStack(spacing: 32){
                        
                        Text("Fofis Cat")
                            .font(.title)
                            .fontWeight(.bold)
                            
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 24)
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Minutos em Atividade")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                    Text("30")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            Divider()
                            
                            HStack{
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 24)
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Semana 03 - Treino 02")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                    Text("Nível 08")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            Divider()
                            
                            HStack{
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 24)
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Strava auth")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                    Text("Disconnected")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            Divider()
                        }
                        
                    }
                    .foregroundStyle(.quasePreto)
                    .padding(.horizontal, 32)
                    Spacer()
                    Image("StravaButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240)
                    
                    Spacer()
                    
                }
                
                
            }
            
            
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "arrow.backward")
                            Text("Perfil")
                        }
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        //.offset(y: 40)
                    }
                }
            }
            
            
        }
        
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ProfileView()
}
