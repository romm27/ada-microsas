//
//  ada_microsasApp.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI
import UserNotifications

//gemini: This delegate class is correct and already handles foreground notifications.
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .list])
    }
}

@main
struct ada_microsasApp: App {
    
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var planViewModel = PlanViewModel()
    
    //gemini: Use the scenePhase environment variable to detect when the app state changes.
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerViewModel)
                .environmentObject(planViewModel)
        }
        //gemini: Add a handler to react to scene phase changes.
        .onChange(of: scenePhase) { newPhase in
            if timerViewModel.timerStatus == .running {
                if newPhase == .background || newPhase == .inactive {
                    //gemini: When the app is no longer active, store the current time.
                    print("App moving to background. Storing current time.")
                    timerViewModel.backgroundEntryTime = Date()
                } else if newPhase == .active {
                    //gemini: When the app becomes active again, sync the timer.
                    print("App became active. Syncing timer.")
                    timerViewModel.syncTimer()
                }
            }
        }
    }
    
}


#Preview {
    ContentView().environmentObject(TimerViewModel()).environmentObject(PlanViewModel())
}


// --- END OF FILE ---
