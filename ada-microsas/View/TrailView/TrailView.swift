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
        ZStack{
            Rectangle().foregroundStyle(Color.cinzaEscuro)
            VStack(){
                ScrollView{
                    VStack(alignment: .leading, spacing: -48) {
                        ForEach(Array(chunks.enumerated()), id: \.element.id)
                        {index, chunk in
                            let displayColor: WorkoutColor = self.trailColors[index % self.trailColors.count]
                            HStack{
                                if index == chunks.count - 1 {
                                    TrailPieceView(workouts: chunk.data, type: .top, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                    .environmentObject(planViewModel)
                                }
                                else if index == 0{
                                    TrailPieceView(workouts: chunk.data, type: .bottom, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                    .environmentObject(planViewModel)
                                    .offset(x: 10)
                                }
                                else{
                                    TrailPieceView(workouts: chunk.data, type: .middle, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                    .environmentObject(planViewModel)
                                }
                            }
                            .offset(x: 15 * (index % 2 != 0 ? 1 : -1))
                        }
                        Image("LogoLight")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 32)
                            .rotationEffect(Angle(degrees: 180))
                            .padding(.vertical, 96)
                            .padding(.horizontal, 64)
                    }
                }
                .rotationEffect(Angle(degrees: 180))
                .padding(.vertical, 32)
                
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
    
    func isTop() -> CGFloat{
        return type == .top ? 1 : 0
    }
    
    func isBottom() -> CGFloat{
        return type == .bottom ? 1 : 0
    }
    
    var body: some View {
        ZStack{
            let trailPieceImage = "TrailPiece\(type.displayName)"
            ZStack{
                Image(trailPieceImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                Image(trailPieceImage + "ColorMask")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(displayColors.trailColor)
            }.scaleEffect(x: flipped ? -1 : 1, y: 1)
            HStack(spacing: 44){
                ForEach(0..<workouts.count, id: \.self){
                    workout in
                    let index = flipped ?  workout : (workouts.count - workout - 1)
                    let globalIndex = (pieceId * 3) + index
                    Button{
                        TrailViewDataCenter.shared.selectedButtonIndex = globalIndex
                        showSheet = true
                    } label:{
                        ZStack{
                            let circleSize = 56
                            Circle()
                                .foregroundStyle(displayColors.workoutBorderColor)
                                .scaledToFit()
                                .frame(height: CGFloat(circleSize))
                            Circle()
                                .foregroundStyle(displayColors.workoutColor)
                                .scaledToFit()
                                .frame(height: CGFloat(circleSize - 5 * 2))
                            if (globalIndex) > planViewModel.userLevel{
                                Image(systemName: "lock.fill")
                                    .foregroundStyle(Color.white)
                                    .bold()
                            }
                            else if globalIndex == planViewModel.userLevel{
                                Image(systemName: "figure.walk")
                                    .foregroundStyle(Color.white)
                                    .bold()
                            }
                        }
                    }
                    .offset(x:40 * (flipped ? 1 : -1), y: 50) // General offset
                    .offset(y : -65 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)) // Move up node uo
                    .offset(x: 10 * isTop(), y: 10 * isTop()) //Fix top piece
                    .offset( //Fix up node of top piece
                        x: -5 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped) * isTop(),
                        y : 9 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped) * isTop())
                    .offset( // Fix up node nodes of Bottom piece
                        y: 3 * isBottom() * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)
                    )
                    .offset( //Fix down nodes of bottom piece
                        x: 11 * isBottom() * isDownWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped),
                        y : -3 * isBottom() * isDownWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped))
                    .offset(x: 7 * (globalIndex == 0 ? 1 : 0)) //fix first workout
                }
                
            }
           
        }
        .rotationEffect(Angle(degrees: 180))
        .padding(.horizontal, 32)
        .padding(.vertical, -13)
        .padding(.vertical, -10 * isBottom())
        .padding(.vertical, 8 * isTop())
        .preferredColorScheme(.dark)
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
