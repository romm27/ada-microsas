//
//  TrailView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct TrailView: View {
    let trail: [Int]
    
    var body: some View {
        let trailCount = trail.count / workoutPerTrailPiece
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<trailCount, id: \.self) { trailPiece in
                    let workouts: [Int] = [1, 2, 3]
                    if trailPiece == trail[0]{
                        TrailPieceView(workouts: workouts, type: .bottom)
                    }
                    else if trailPiece == trail[trailCount]{
                        TrailPieceView(workouts: workouts, type: .top)
                    }
                    else{
                        TrailPieceView(workouts: workouts, type: .middle)
                    }
                }
            }

        }
        .rotationEffect(Angle(degrees: 180))
    }
}

enum PieceType: String{
    case top, middle, bottom
}

let workoutPerTrailPiece: Int = 3
struct TrailPieceView: View {    let workouts: [Int]
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
