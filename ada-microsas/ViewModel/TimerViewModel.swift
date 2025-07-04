//
//  TimerViewModel.swift
//  ada-microsas
//
//  Created by Eduardo Bertol on 25/06/25.
//

import Foundation

class TimerViewModel: ObservableObject {
    
    enum TimerStatus {
        case running
        case paused
    }
    
    enum TrainState {
        case training
        case resting
    }
    
    @Published var timerStatus: TimerStatus = .paused //estado do timer
    @Published var trainState: TrainState = .training //estado do treino
    @Published var currentTimer: Int = 0 //nosso controle do tempo
    var maxTimer: Int = 0
    
    @Published var progress: Double = 0.0
    @Published var isFinished: Bool = false
    
    var formattedCurrentTimer: String {
        let minutes = currentTimer / 60
        let seconds = currentTimer % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var timer: Timer? //o timer, em si
    
    
    //GETTERS
    func getCurrentTimer() -> Int {
        return currentTimer
    }
    
    func getFormattedCurrentTimer() -> String {
        return formattedCurrentTimer
    }
    
    func getTimerStatus() -> TimerStatus {
        return timerStatus
    }
    
    
    //METHODS
    
    //Estabelece a configuração inicial da instância do timer
    func setTimerConfig(seconds: Int) {
        currentTimer = seconds
        maxTimer = seconds
        isFinished = false
    }
    
    func startTimer() {
        print("Timer iniciado!")
        timerStatus = .running
        
        //isso inicia um timer (a checagem para parar ele vai no #selector)
        //timer intervalado de 1 seg, mas a checagem do tempo é nossa e manual (currentTimer)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimeExecution), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        print("Timer pausado!")
        timerStatus = .paused
        
        self.timer?.invalidate() //isso para o timer
    }
    
    @objc private func handleTimeExecution() {
        if self.currentTimer <= 0 {
            self.timer?.invalidate() //isso para o timer
            self.endTimer()
            
        } else {
            print("Tempo em execução: \(self.currentTimer)")
            print("Progresso: \(self.progress)")
            print("Max: \(self.maxTimer)")

            self.currentTimer -= 1 //a execução do timer, de fato
            self.progress = 1.0 - (Double(self.currentTimer) / Double(self.maxTimer)) //o progresso sendo atualizado
        }
    }
    
    func endTimer() {
        print("Tempo encerrado!")
        
        isFinished = true
        timerStatus = .paused
        resetTimer()
    }
    
    private func resetTimer() {
        print("Timer resetado!")
        
        currentTimer = 0
        maxTimer = 0
    }
    
}
