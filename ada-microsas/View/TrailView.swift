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
                        TrailPieceView(workouts: chunk.data, type: .top)
                    }
                    else if index == 0{
                        TrailPieceView(workouts: chunk.data, type: .bottom)
                    }
                    else{
                        TrailPieceView(workouts: chunk.data, type: .middle)
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
    var body: some View {
        ZStack{
            Rectangle().frame(width: 250, height: 150).foregroundColor(type == .middle ? .blue : .gray)
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
