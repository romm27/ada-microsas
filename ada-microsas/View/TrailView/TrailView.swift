//
//  TrailView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct TrailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var planViewModel: PlanViewModel
    let trail: [ActivityModel] = DataTrainingModel.shared.trainingList
    @ObservedObject var trailViewDataCenter: TrailViewDataCenter = .shared
    @State private var shouldNavigateToActivity = false
    
    let trailColorInterval: Int = 4
    let trailColors: [WorkoutColor] = [
            WorkoutColor(trailColor: .azul, workoutColor: .azulBotao, workoutBorderColor: .azulBotaoBorda),
            WorkoutColor(trailColor: .rosa, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
            WorkoutColor(trailColor: .verdeLima, workoutColor: .verdeLimaBotao, workoutBorderColor: .verdeLimaBotaoBorda),
            WorkoutColor(trailColor: .roxo, workoutColor: .roxoBotao, workoutBorderColor: .roxoBotaoBorda)
        ]
    
    // Define a ordem de cores das bolinhas, se ficar sem cores ele vai lupar de novo para o começo
    let trailColorPattern = [0,0,0, 1, 1 ,1, 2, 2 ,2, 3 ,3 ,3]
    
    init(){
        
        //Pede permissão de usuario apos spalshscreen
        requestNotificationPermission()
    }
    
    // 1. Função que cuida do pedido de permisão para usar as features que precisamos do iphone.
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
                return
            }
            
            if granted {
                print("Permission Granted!")
                // You could schedule a notification here if you want one immediately after permission is given
            } else {
                print("Permission Denied")
            }
        }
    }
    
    // Função que checa se o usuário consentiu ao uso das features.
    func checkNotificationPermissionStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    
    //=====================================================================================
    // 4. Exemplo de uso do consentimento do usuario do Gemini
    //        func exampleScheduleActualNotification() {
    //            // First, check the current status
    //            checkNotificationPermissionStatus { status in
    //                switch status {
    //                case .authorized:
    //                    // Permission already granted, schedule the notification
    //                    print("Status is authorized. Scheduling notification.")
    //                    exampleScheduleActualNotification()
    //
    //                case .denied:
    //                    // Permission denied. Guide user to settings.
    //                    print("Status is denied. Cannot schedule notification.")
    //                    // Here you might want to show an alert to the user.
    //
    //                case .notDetermined:
    //                    // Permission not yet requested. Ask for it.
    //                    print("Status is not determined. Requesting permission.")
    //                    requestNotificationPermission()
    //                    // The user will see the pop-up. If they grant it, you might want to
    //                    // schedule the notification inside the request's completion handler.
    //
    //                default:
    //                    // Handle other cases like .provisional, etc.
    //                    print("Unhandled notification status.")
    //                }
    //            }
    //        }
    //=========================================================================================
    
    
    var body: some View {
        ZStack{
            Rectangle().foregroundStyle(Color.cinzaEscuro).ignoresSafeArea()
            VStack(){
                ScrollViewReader{ proxy in
                    ScrollView{
                        VStack {
                            Image("Trail")
                                .resizable()
                                .scaledToFit()
                                // 1. Apply the overlay FIRST, directly to the un-padded image.
                                .overlay {
                                    GeometryReader { geometry in
                                        ZStack {
                                            ForEach(trail.indices, id: \.self) { index in
                                                let activity = trail[index]
                                                let workoutColor = trailColors[trailColorPattern[index % trailColorPattern.count]]
                                                let relativePosition = getRelativePosition(for: index, total: trail.count)
                                                
                                                WorkoutTrailDisplay(
                                                    workoutColor: workoutColor,
                                                    activity: activity,
                                                    imageSize: geometry.size
                                                )
                                                .environmentObject(planViewModel)
                                                .position(
                                                    x: geometry.size.width * relativePosition.x,
                                                    y: geometry.size.height * relativePosition.y
                                                )
                                            }
                                        }
                                    }
                                }
                                // 2. THEN, apply the padding to the combined view (Image + Overlay).
                                .padding(.vertical, 48)

                            Spacer().id("bottomAnchor")
                        }
                    }
                    .scrollIndicators(.hidden)
                    .onAppear {
                        proxy.scrollTo("bottomAnchor")
                    }
                }
            }
            .padding(.horizontal, 56)
        }.navigationBarBackButtonHidden(true)
    }
    
    //Gera posição certa da bolinha com base no index dela, RIP 8 Offsets
    private func getRelativePosition(for index: Int, total: Int) -> CGPoint {
        let topMargin: Double = 0.0275
        let bottomMargin: Double = 0.03
        let horizontalMargin: Double = 0.08

        let verticalCanvasHeight = 1.0 - topMargin - bottomMargin
        let horizontalCanvasWidth = 1.0 - (horizontalMargin * 2)

        let step = index / 3
        let iteration = index % 3
        let isFlipped = (step % 2 != 0)
        
        var relativeY = 1.0 - (Double(step) / Double(total / 3))

        var relativeX: Double
        if iteration == 0 {
            relativeX = 0.35
        } else if iteration == 1 {
            relativeX = 0.65
        } else { // terceiro no
            relativeX = 0.99
        }

        if isFlipped { // Inverte a cada 3 nos
            relativeX = 1.0 - relativeX
        }
        
        if iteration == 2 { //sobe terceiro no
            relativeY -= 0.06
        }
        
        let finalX = horizontalMargin + (relativeX * horizontalCanvasWidth)
        let finalY = topMargin + (relativeY * verticalCanvasHeight)
        
        return CGPoint(x: finalX, y: finalY)
    }
}
    
    struct WorkoutTrailDisplay : View {
        @Environment(\.dismiss) var dismiss
        @EnvironmentObject var planViewModel: PlanViewModel
        let workoutColor: WorkoutColor
        let activity: ActivityModel
        let imageSize: CGSize
        
        
        var body: some View {
            let diameter = imageSize.width * 0.14 //Fator de tamanho da bolinha (divida a largura da bolinha somada da borda dela, pela trail no figma)
            
            let borderDiameter = diameter * 0.82
            ZStack{
                Circle()
                    .foregroundStyle(workoutColor.workoutBorderColor)
                    .frame(width: diameter, height: diameter)
                Circle()
                    .foregroundStyle(workoutColor.workoutColor)
                    .frame(width: borderDiameter,height: borderDiameter)
            }
                
        }
        
    }
    
struct ChunkedData<T>: Identifiable {
    let id: UUID = UUID()
    let data : [T]
}

enum PieceType {
    case top, middle, bottom
    
    var displayName: String {
        switch self {
        case .top:
            return "Top"
        case .middle:
            return "Middle"
        case .bottom:
            return "Bottom"
        }
    }
}

class TrailViewDataCenter: ObservableObject{
    static let shared = TrailViewDataCenter()
    
    @Published var showSheet = false
    @Published var selectedButtonIndex: Int = 0
    @Published var userLevel: Int = 1
}

struct WorkoutColor{
    let trailColor: Color
    let workoutColor: Color
    let workoutBorderColor: Color
}

#Preview {
    TrailView().environmentObject(PlanViewModel())
}
