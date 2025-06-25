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
    
    init(trail: [Int]){
        self.trail = trail
        
        let workoutPerTrailPiece = 3
        let steps = stride(from: 0, to: trail.count, by: workoutPerTrailPiece)
        
        for start in steps{
            self.chunks.append(ChunkedData<Int>(data: Array(trail[start..<min(start+workoutPerTrailPiece, trail.count)])))
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(chunks.enumerated()), id: \.element.id)
                {index, chunk in
                    if index == chunks.count - 1 {
                        TrailPieceView(workouts: chunk.data, type: .top, flipped: index % 2 == 0)
                    }
                    else if index == 0{
                        TrailPieceView(workouts: chunk.data, type: .bottom, flipped: index % 2 == 0)
                    }
                    else{
                        TrailPieceView(workouts: chunk.data, type: .middle, flipped: index % 2 == 0)
                    }
                }
            }

        }
        .rotationEffect(Angle(degrees: 180))
    }
}


struct ChunkedData<T>: Identifiable {
    let id: UUID = UUID()
    let data : [T]
    
}


enum PieceType: String{
    case top, middle, bottom
}

struct TrailPieceView: View {
    let workouts: [Int]
    let type: PieceType
    let flipped: Bool
    var body: some View {
        ZStack{
            Image("trail_piece_" + type.rawValue).resizable().scaledToFill().scaleEffect(x: flipped ? -1 : 1, y: 1)
            HStack(spacing: 36){
                ForEach(0..<workouts.count, id: \.self){
                    workout in
                    Text("\(workouts[workout])")
                }
            }
        }
        .rotationEffect(Angle(degrees: 180))
    }
}

#Preview {
    TrailView(trail: Array(1...24))
}
