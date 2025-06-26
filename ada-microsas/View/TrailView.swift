//
//  TrailView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct TrailView: View {
    let trail: [Int]
    var chunks: [ChunkedData<Int>] = []
    var trailColors: [WorkoutColor] = [
        WorkoutColor(trailColor: .brancoGelo, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .rosa, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .verdeLima, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .roxo, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda)
    ]
    
    init(trail: [Int]){
        self.trail = trail
        
        let workoutPerTrailPiece = 3
        let steps = stride(from: 0, to: trail.count, by: workoutPerTrailPiece)
        
        for start in steps{
            self.chunks.append(ChunkedData<Int>(data: Array(trail[start..<min(start+workoutPerTrailPiece, trail.count)])))
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle().foregroundStyle(Color.cinzaEscuro)
            ScrollView{
                VStack(alignment: .leading, spacing: -48) {
                    ForEach(Array(chunks.enumerated()), id: \.element.id)
                    {index, chunk in
                        let displayColor: WorkoutColor = self.trailColors[index % self.trailColors.count]
                        HStack{
                            if index == chunks.count - 1 {
                                TrailPieceView(workouts: chunk.data, type: .top, flipped: index % 2 == 0,
                                displayColors: displayColor)
                            }
                            else if index == 0{
                                TrailPieceView(workouts: chunk.data, type: .bottom, flipped: index % 2 == 0,
                                               displayColors: displayColor)
                                    .offset(x: 10)
                            }
                            else{
                                TrailPieceView(workouts: chunk.data, type: .middle, flipped: index % 2 == 0,
                                               displayColors: displayColor)
                            }
                        }
                        .offset(x: 15 * (index % 2 != 0 ? 1 : -1))
                    }
                }

            }
            .rotationEffect(Angle(degrees: 180))
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

struct TrailPieceView: View {
    let workouts: [Int]
    let type: PieceType
    let flipped: Bool
    let displayColors: WorkoutColor
    
    func getWorkoutYModifier(index: Int, totalWorkouts: Int, flipped: Bool) -> Int{
        
        if index == 0 && !flipped || index == totalWorkouts-1 && flipped{
            return -1
        }
        else {
            return 0
        }
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
                    ZStack{
                        let circleSize = 55
                        Circle()
                            .foregroundStyle(displayColors.workoutBorderColor)
                            .scaledToFit()
                            .frame(height: CGFloat(circleSize))
                        Circle()
                            .foregroundStyle(displayColors.workoutColor)
                            .scaledToFit()
                            .frame(height: CGFloat(circleSize - 5 * 2))
                        Text("\(workouts[workout])")
                            .foregroundStyle(.white)
                    }
                    .offset(x:40 * (flipped ? 1 : -1), y: 50)
                    .offset(y : CGFloat(65 * getWorkoutYModifier(index: workout, totalWorkouts: workouts.count, flipped: flipped)))
                }
            }
        }
        .rotationEffect(Angle(degrees: 180))
        .padding(.horizontal, 32)
    }
}

struct WorkoutColor{
    let trailColor: Color
    let workoutColor: Color
    let workoutBorderColor: Color
}

#Preview {
    TrailView(trail: Array(1...24))
}
