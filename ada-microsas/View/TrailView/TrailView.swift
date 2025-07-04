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
                                .overlay {
                                    GeometryReader { geometry in
                                        ZStack {
                                            ForEach(trail.indices, id: \.self) { index in
                                                let activity = trail[index]
                                                let workoutColor = trailColors[trailColorPattern[index % trailColorPattern.count]]
                                                let relativePosition = getRelativePosition(for: index, total: trail.count)
                                                
                                                Button {
                                                    trailViewDataCenter.selectedButtonIndex = index
                                                    trailViewDataCenter.showSheet = true
                                                } label: {
                                                    WorkoutTrailDisplay(
                                                        workoutColor: workoutColor,
                                                        activity: activity,
                                                        imageSize: geometry.size,
                                                        orderInArray: index
                                                    )
                                                }
                                                .environmentObject(planViewModel)
                                                .position(
                                                    x: geometry.size.width * relativePosition.x,
                                                    y: geometry.size.height * relativePosition.y
                                                )
                                            }
                                        }
                                    }
                                }
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
            .padding(.horizontal, 36)
        }
        .overlay {
            if trailViewDataCenter.showSheet {
                Color.black.opacity(0.6)
                    .ignoresSafeArea(.all)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: trailViewDataCenter.showSheet)
                    .onTapGesture {
                        trailViewDataCenter.showSheet = false
                    }
            }
        }
        .sheet(isPresented: $trailViewDataCenter.showSheet){
            TrainerSheetView(currentIndex: trailViewDataCenter.selectedButtonIndex, shouldStartActivity: $shouldNavigateToActivity)
                .presentationDetents([.medium, .height(600)])
        }
        .navigationDestination(isPresented: $shouldNavigateToActivity) {
            ActivityView().environmentObject(planViewModel)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //rip 8 Offsets
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
        } else {
            relativeX = 0.99
        }
        
        if isFlipped {
            relativeX = 1.0 - relativeX
        }
        
        if iteration == 2 {
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
    let orderInArray: Int
    
    var body: some View {
        
        let diameter = imageSize.width * 0.14
        
        let innerDiameter = diameter * 0.82
        ZStack{
            Circle()
                .foregroundStyle(workoutColor.workoutBorderColor)
                .frame(width: diameter, height: diameter)
            Circle()
                .foregroundStyle(workoutColor.workoutColor)
                .frame(width: innerDiameter,height: innerDiameter)
                .overlay{
                    //se eu nao fiz ainda
                    if orderInArray > planViewModel.userLevel{
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                    //se eu to nesse nível
                    else if orderInArray == planViewModel.userLevel{
                        Circle()
                            .frame(width: innerDiameter, height: innerDiameter)
                            .overlay {
                                Image("AvatarCareca")
                                    .resizable()
                                    .scaledToFit()
                            }
                    }
                    //se eu ja fiz
                    else{
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
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
