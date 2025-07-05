//
//  TrailView.swift
//  ada-microsas
//
//  Created by Carla Araujo on 25/06/25.
//

import SwiftUI
import UserNotifications

struct TrailView: View {
    @EnvironmentObject var planViewModel: PlanViewModel
    @EnvironmentObject var timerViewModel: TimerViewModel
    let trail: [WorkoutPlan] = DataTrainingModel.shared.trainingPlans
    
    let trailColors: [WorkoutColor] = [
        WorkoutColor(trailColor: .azul, workoutColor: .azulBotao, workoutBorderColor: .azulBotaoBorda),
        WorkoutColor(trailColor: .rosa, workoutColor: .rosaBotao, workoutBorderColor: .rosaBotaoBorda),
        WorkoutColor(trailColor: .verdeLima, workoutColor: .verdeLimaBotao, workoutBorderColor: .verdeLimaBotaoBorda),
        WorkoutColor(trailColor: .roxo, workoutColor: .roxoBotao, workoutBorderColor: .roxoBotaoBorda)
    ]
    
    let trailColorPattern = [0,0,0, 1, 1 ,1, 2, 2 ,2, 3 ,3 ,3]
    
    var body: some View {
        NavigationStack {
            trailContentView
        }
    }
    
    private var trailContentView: some View {
        ZStack {
            backgroundView
            trailItemsView
        }
    }
    
    private var backgroundView: some View {
        Rectangle()
            .foregroundStyle(Color.cinzaEscuro)
            .ignoresSafeArea()
    }
    
    private var trailItemsView: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    trailImageWithOverlay
                        .padding(.vertical, 48)
                    Spacer().id("bottomAnchor")
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo("bottomAnchor")
                    requestNotificationPermission()
                }
            }
        }
        .padding(.horizontal, 36)
    }
    
    private var trailImageWithOverlay: some View {
        Image("Trail")
            .resizable()
            .scaledToFit()
            .overlay(trailItemsOverlay)
    }
    
    private var trailItemsOverlay: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(trail.indices, id: \.self) { index in
                    trailItem(for: index, geometry: geometry)
                }
            }
        }
    }
    
    private func trailItem(for index: Int, geometry: GeometryProxy) -> some View {
        let position = getRelativePosition(for: index, total: trail.count)
        let workoutColor = trailColors[trailColorPattern[index % trailColorPattern.count]]
        
        return NavigationLink {
            ActivityView()
                .environmentObject(planViewModel)
                .environmentObject(timerViewModel)
                .onDisappear {
                    timerViewModel.pauseTimer()
                }
        } label: {
            WorkoutTrailDisplay(
                workoutColor: workoutColor,
                workoutPlan: trail[index],
                imageSize: geometry.size,
                orderInArray: index
            )
        }
        .environmentObject(planViewModel)
        .position(
            x: geometry.size.width * position.x,
            y: geometry.size.height * position.y
        )
    }
    
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
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification Permission Granted!")
            }
        }
    }
}

struct WorkoutTrailDisplay: View {
    @EnvironmentObject var planViewModel: PlanViewModel
    let workoutColor: WorkoutColor
    let workoutPlan: WorkoutPlan
    let imageSize: CGSize
    let orderInArray: Int
    
    var body: some View {
        let diameter = imageSize.width * 0.14
        let innerDiameter = diameter * 0.82
        
        ZStack {
            Circle()
                .foregroundStyle(workoutColor.workoutBorderColor)
                .frame(width: diameter, height: diameter)
            Circle()
                .foregroundStyle(workoutColor.workoutColor)
                .frame(width: innerDiameter, height: innerDiameter)
                .overlay{
                    if orderInArray == planViewModel.userLevel + 1 {
                        Image(systemName: "lock.open.fill")
                            .foregroundStyle(Color.white)
                            .bold()
                    } else if orderInArray > planViewModel.userLevel {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Color.white)
                            .bold()
                    } else if orderInArray == planViewModel.userLevel {
                        Circle()
                            .frame(width: innerDiameter, height: innerDiameter)
                            .overlay {
                                Image("AvatarCareca")
                                    .resizable()
                                    .scaledToFit()
                            }
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
        }
    }
}

struct WorkoutColor {
    let trailColor: Color
    let workoutColor: Color
    let workoutBorderColor: Color
}

#Preview {
    TrailView()
        .environmentObject(PlanViewModel())
        .environmentObject(TimerViewModel())
}
