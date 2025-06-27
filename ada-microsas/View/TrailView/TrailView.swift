//
//  TrailView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct TrailView: View {
    let trail: [ActivityModel] = DataTrainingModel.shared.trainingList
    @ObservedObject var trailViewDataCenter: TrailViewDataCenter = .shared
    @State private var shouldNavigateToActivity = false

    var chunks: [ChunkedData<ActivityModel>] = []
    var trailColors: [WorkoutColor] = [
        WorkoutColor(trailColor: .brancoGelo, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .rosa, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .verdeLima, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .roxo, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda)
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
                //Image("logo")
                ScrollView{
                    VStack(alignment: .leading, spacing: -48) {
                        ForEach(Array(chunks.enumerated()), id: \.element.id)
                        {index, chunk in
                            let displayColor: WorkoutColor = self.trailColors[index % self.trailColors.count]
                            HStack{
                                if index == chunks.count - 1 {
                                    TrailPieceView(workouts: chunk.data, type: .top, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                }
                                else if index == 0{
                                    TrailPieceView(workouts: chunk.data, type: .bottom, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                        .offset(x: 10)
                                }
                                else{
                                    TrailPieceView(workouts: chunk.data, type: .middle, flipped: index % 2 == 0,
                                                   displayColors: displayColor, pieceId: index, showSheet: $trailViewDataCenter.showSheet)
                                }
                            }
                            .offset(x: 15 * (index % 2 != 0 ? 1 : -1))
                        }
                    }

                }
                .rotationEffect(Angle(degrees: 180))
            }
        }
        .sheet(isPresented: $trailViewDataCenter.showSheet){
            TrainerSheetView(currentIndex: trailViewDataCenter.selectedButtonIndex, shouldStartActivity: $shouldNavigateToActivity)
                .presentationDetents([.medium])
        }
        .navigationDestination(isPresented: $shouldNavigateToActivity) {
            ActivityView()
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
                Image(trailPieceImage).resizable().scaledToFill()
                Image(trailPieceImage + "ColorMask").resizable().scaledToFill().foregroundColor(displayColors.trailColor)
            }.scaleEffect(x: flipped ? -1 : 1, y: 1)
            HStack(spacing: 44){
                ForEach(0..<workouts.count, id: \.self){
                    workout in
                    let index = flipped ?  workout : (workouts.count - workout - 1)
                    Button{
                        TrailViewDataCenter.shared.selectedButtonIndex = (pieceId * 3) + workout
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
                            //Text("\(workouts[index])")
//                            Image(systemName: (pieceId * 3) + workout)
//                                .foregroundStyle(.white)
                        }
                    }
                    .offset(x:40 * (flipped ? 1 : -1), y: 50) // General offset
                    .offset(y : -65 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)) // Move up node uo
                    .offset(x: 10 * isTop(), y: 10 * isTop()) //Fix top piece
                    .offset( //Fix up node of top piece
                    x: -5 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped) * isTop(),
                    y : 9 * isUpWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped) * isTop())
                    .offset( // Fix up node nodes of Bottom piece
                        y: -3 * isBottom() * isDownWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped)
                    )
                    .offset( //Fix down nodes of bottom piece
                    x: 13 * isBottom() * isDownWorkout(index: index, totalWorkouts: workouts.count, flipped: flipped),
                    y : 0)
                }
            }
        }
        .rotationEffect(Angle(degrees: 180))
        .padding(.horizontal, 32)
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
    TrailView()
}
