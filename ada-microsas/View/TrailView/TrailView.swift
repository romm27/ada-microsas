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
    
    var chunks: [ChunkedData<ActivityModel>] = []
    var trailColors: [WorkoutColor] = [
        WorkoutColor(trailColor: .azul, workoutColor: .azulBotao, workoutBorderColor: .azulBotaoBorda),
        WorkoutColor(trailColor: .rosa, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .verdeLima, workoutColor: .verdeLimaBotao, workoutBorderColor: .verdeLimaBotaoBorda),
        WorkoutColor(trailColor: .roxo, workoutColor: .roxoBotao, workoutBorderColor: .roxoBotaoBorda)
    ]
    
    init(){
        let workoutPerTrailPiece = 3
        let steps = stride(from: 0, to: trail.count, by: workoutPerTrailPiece)
        
        for start in steps{
            self.chunks.append(ChunkedData<ActivityModel>(data: Array(trail[start..<min(start+workoutPerTrailPiece, trail.count)])))
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle().foregroundStyle(Color.cinzaEscuro).ignoresSafeArea()
                VStack(){
                    ScrollView{
                        let pieceHeight = geometry.size.width * 0.45
                        
                        VStack(alignment: .leading, spacing: -pieceHeight * 0.17) {
                            ForEach(Array(chunks.enumerated()), id: \.element.id)
                            {index, chunk in
                                let displayColor: WorkoutColor = self.trailColors[index % self.trailColors.count]
                                
                                let pieceType: PieceType = {
                                    if index == chunks.count - 1 { return .top }
                                    if index == 0 { return .bottom }
                                    return .middle
                                }()
                                
                                TrailPieceView(workouts: chunk.data, type: pieceType, flipped: index % 2 == 0,
                                               displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet,
                                               availableSize: geometry.size, pieceHeight: pieceHeight)
                                .environmentObject(planViewModel)
                                .offset(calculatePieceOffset(for: index, count: chunks.count, pieceHeight: pieceHeight, screenWidth: geometry.size.width))
                            }
                            Image("LogoLight")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                                .rotationEffect(Angle(degrees: 180))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, geometry.size.height * 0.1)
                        }
                    }
                    .rotationEffect(Angle(degrees: 180))
                    //aqui modifica a parte cinza de cima, caso precise
    //                .padding(.vertical, 48)
                    .padding(.top, 48)
                    .padding(.bottom, 32)
                }
            }
            .overlay {
                if trailViewDataCenter.showSheet { //
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
    }
    
    private func calculatePieceOffset(for index: Int, count: Int, pieceHeight: CGFloat, screenWidth: CGFloat) -> CGSize {
        var x: CGFloat = 0
        var y: CGFloat = 0

        // --- Offset for entire peace
        let topPieceAdjustment    = (x: pieceHeight * 0, y: pieceHeight * -0.015)
        let bottomPieceAdjustment = (x: screenWidth * 0.025, y: pieceHeight * 0.0)
        // ---------------------------------------------------

        // Zig zag
        x += screenWidth * 0.04 * (index % 2 != 0 ? 1 : -1)

        // Adjust top and bottom pieces
        if index == count - 1 { // Top piece
            x += topPieceAdjustment.x
            y += topPieceAdjustment.y
        } else if index == 0 { // Bottom piece
            x += bottomPieceAdjustment.x
            y += bottomPieceAdjustment.y
        }
        
        return CGSize(width: x, height: y)
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

struct TrailPieceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var planViewModel: PlanViewModel
    let workouts: [ActivityModel]
    let type: PieceType
    let flipped: Bool
    let displayColors: WorkoutColor
    let pieceId: Int
    @Binding var showSheet: Bool
    
    let availableSize: CGSize
    let pieceHeight: CGFloat
    
    private var buttonSize: CGFloat { pieceHeight * 0.28 }
    private var buttonBorderSize: CGFloat { buttonSize + 10 }
    
    func isUpWorkout(index: Int, totalWorkouts: Int, flipped: Bool) -> CGFloat{
        if index == totalWorkouts - 1{
            return 1
        }
        else {
            return 0
        }
    }
    
    func isDownWorkout(index: Int, totalWorkouts: Int, flipped: Bool) -> CGFloat{
        return isUpWorkout(index: index, totalWorkouts: totalWorkouts, flipped: flipped) == 0 ? 1 : 0
    }
    
    var body: some View {
        ZStack{
            let trailPieceImage = "TrailPiece\(type.displayName)"
            ZStack{
                Image(trailPieceImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: pieceHeight)
                Image(trailPieceImage + "ColorMask")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: pieceHeight)
                    .foregroundColor(displayColors.trailColor)
            }
            .scaleEffect(x: flipped ? -1 : 1, y: 1)
            
            HStack(spacing: availableSize.width * 0.10){
                ForEach(0..<workouts.count, id: \.self){
                    workout in
                    let index = flipped ?  workout : (workouts.count - workout - 1)
                    let globalIndex = (pieceId * 3) + index
                    Button{
                        TrailViewDataCenter.shared.selectedButtonIndex = globalIndex
                        showSheet = true
                    } label:{
                        ZStack{
                            Circle()
                                .foregroundStyle(displayColors.workoutBorderColor)
                                .frame(width: buttonBorderSize, height: buttonBorderSize)
                                .shadow(color: .black.opacity(0.35), radius: 5, x: 0, y: 4)
                            Circle()
                                .foregroundStyle(displayColors.workoutColor)
                                .frame(width: buttonSize, height: buttonSize)
                            
                            
                            //se eu nao fiz ainda
                            if (globalIndex) > planViewModel.userLevel{
                                Image(systemName: "lock.fill")
                                    .foregroundStyle(Color.white)
                                    .bold()
                            }
                            //se eu to nesse nível
                            else if globalIndex == planViewModel.userLevel{
                                Circle()
                                    .frame(width: buttonSize, height: buttonSize)
                                    .overlay {
                                        Image("AvatarCareca")
                                            .resizable()
                                            .scaledToFit()
                                    }
                            }
                            //se eu ja fiz
                            else if globalIndex == planViewModel.userLevel{
                                //nao acontece nada como o botao
                            }
                        }
                    }
                    .offset(calculateWorkoutOffset(forIndex: index, globalIndex: globalIndex))
                }
            }
        }
        .rotationEffect(Angle(degrees: 180))
        .padding(.horizontal, availableSize.width * 0.08)
        .padding(.vertical, -pieceHeight * 0.065)
        .padding(.vertical, -pieceHeight * 0.05 * (type == .bottom ? 1 : 0))
        .padding(.vertical, pieceHeight * 0.04 * (type == .top ? 1 : 0))
        .preferredColorScheme(.dark)
    }
    
    private func calculateWorkoutOffset(forIndex index: Int, globalIndex: Int) -> CGSize {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let upFlag = isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)
        let downFlag = isDownWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)

        // Middle Piece
        // General offset
        x += (pieceHeight * 0.2) * (flipped ? 1 : -1)
        y += pieceHeight * 0.25
        
        // Move up node
        x += pieceHeight * 0.015 * upFlag * (flipped ? 1 : -1)
        y -= pieceHeight * 0.325 * upFlag
        
        // Move down nodes
        x += pieceHeight * 0.01 * downFlag * (flipped ? 1 : -1)
        y += pieceHeight * 0.02 * downFlag

        // Adjust top and bottom piece nodes
        switch type {
        case .top:
            // Fix top piece
            x += pieceHeight * 0.06
            y += pieceHeight * 0.05
            
            // Fix up node of top piece
            x += pieceHeight * 0.0125 * upFlag
            y += pieceHeight * 0.045 * upFlag
            
            // Fix down nodes of top piece
            x -= pieceHeight * 0.015 * downFlag
            
        case .bottom:
            // Fix up node nodes of Bottom piece
            y += pieceHeight * 0.015 * upFlag
            
            // Fix down nodes of bottom piece
            x += pieceHeight * 0.055 * downFlag
            
        case .middle:
            break
        }
        
        // fix first workout
        if globalIndex == 0 {
            x += pieceHeight * 0.035
        }
        
        return CGSize(width: x, height: y)
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
