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
    
    @Published var isPaused: Bool = false
    
    @Published var timerStatus: TimerStatus = .paused
    @Published var currentTimer: Int = 0 //variável temporária
    //var maxTimer: Int = 0 //setado quando instanciamos essa ViewModel
    
    private var timer: Timer?
    
    func setTimerConfig(seconds: Int) {
        currentTimer = seconds
    }
    
    func startTimer() {
        print("Timer iniciado!")
        timerStatus = .running
        
        //Logica do Timer Genérico
        //Enquanto o tempo atual for menor E não esteja pausado
        while currentTimer > 0 && timerStatus == .running {
            currentTimer -= 1
            sleep(1)
            print(currentTimer)
        }
        
        if currentTimer <= 0 {
            endTimer()
        }
    }
    
    func startTimer2() {
        print("Timer iniciado!")
        timerStatus = .running
        isPaused = false
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimeExecution), userInfo: nil, repeats: true)
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: !isPaused) { timer in //repeats significa para ele repetir esse timer até que eu interrompa
//            print("\(self.currentTimer)")
//
//            if self.currentTimer <= 0 {
//                timer.invalidate()
//                self.endTimer()
//            } else{
//                
//                self.currentTimer -= 1
//            }
//        }
    }
    
    @objc private func handleTimeExecution() {
        if self.currentTimer <= 0 {
            self.timer?.invalidate()
            self.endTimer()
        } else{
            print("timer executed: \(self.currentTimer)")
            self.currentTimer -= 1
        }
    }
    
    func pauseTimer() {
        print("Timer pausado!")
        timerStatus = .paused
        isPaused = true
        
        self.timer?.invalidate() //isso para o timer
    }
    
    func getCurrentTimer() -> Int {
        return currentTimer
    }
    
    func getTimerStatus() -> TimerStatus {
        return timerStatus
    }
    
    private func endTimer() {
        print("Tempo encerrado!")
        
        timerStatus = .paused
        isPaused = true
        resetTimer()
    }
    
    private func resetTimer() {
        print("Timer resetado!")
        
        currentTimer = 0
//        maxTimer = 0
    }
    
}
