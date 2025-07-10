//
//  NotificationManager.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 09/07/25.
//

import UserNotifications

/// A singleton class to manage all local notification logic for the app.
class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification Permission Granted!")
            } else if let error = error {
                print("❌ Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Schedules notifications for all phase transitions in a workout plan
    func scheduleWorkoutNotifications(for workout: WorkoutPlan) {
        // Schedule for all phases starting from the beginning
        //scheduleNotifications(for: workout.allPhases, initialPhaseRemainingTime: nil)
    }

    /// Reschedules notifications when resuming a workout, accounting for time already spent in current phase
    func rescheduleNotificationsOnResume(remainingPhases: [ActivityPhase], currentTime: Int) {
        // Re-schedule for the remaining phases with the current phase's remaining time
        //scheduleNotifications(for: remainingPhases, initialPhaseRemainingTime: currentTime)
    }

    /// Core scheduling logic that handles both new workouts and resumed workouts
    /// - Parameters:
    ///   - phases: The activity phases to schedule notifications for
    ///   - initialPhaseRemainingTime: For resumed workouts, the remaining time in seconds for the current phase
    private func scheduleNotifications(for phases: [ActivityPhase], initialPhaseRemainingTime: Int?) {
            // Always clear old notifications first to avoid duplicates
            cancelAllNotifications()
            
            // Need at least 2 phases to schedule transitions between them
            guard phases.count > 1 else {
                print("⚠️ Not enough phases to schedule transitions (need at least 2)")
                return
            }
            
            print("\n📋 STARTING NOTIFICATION SCHEDULING FOR \(phases.count) PHASES")
            print("--------------------------------------------------")

            // Track the total delay from "now" when each notification should fire
            var cumulativeDelay: TimeInterval = 0
            
            // Handle first phase duration - use remaining time if resuming, otherwise full duration
            if let remainingTime = initialPhaseRemainingTime {
                cumulativeDelay += TimeInterval(remainingTime)
                print("⏱️ Using remaining time for first phase: \(remainingTime)s")
            } else {
                cumulativeDelay += TimeInterval(phases[0].duration)
                print("⏱️ Using full duration for first phase: \(phases[0].duration)s")
            }
            
            // Schedule notifications for each phase transition
            for i in 0..<(phases.count - 1) {
                let nextPhase = phases[i + 1]
                let currentPhase = phases[i]
                
                // Create notification content
                let content = UNMutableNotificationContent()
                content.title = "\(currentPhase.name) concluído!"
                content.body = "Próxima etapa: \(nextPhase.name)"
                content.sound = .default // Use default sound for reliability
                
                // Create trigger with cumulative delay
                let trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: cumulativeDelay,
                    repeats: false
                )
                
                // Generate unique identifier
                let requestId = "workout_phase_\(UUID().uuidString)"
                let request = UNNotificationRequest(
                    identifier: requestId,
                    content: content,
                    trigger: trigger
                )
                
                // Schedule the notification
                UNUserNotificationCenter.current().add(request)
                
                // Enhanced debugging
                print("\n🔔 SCHEDULED NOTIFICATION #\(i+1)")
                print("   - For transition: \(currentPhase.name) → \(nextPhase.name)")
                print("   - Triggering in: \(cumulativeDelay) seconds")
                print("   - ID: \(requestId)")
                
                // CRITICAL FIX: Add duration of the CURRENT phase to cumulative delay AFTER scheduling
                cumulativeDelay += TimeInterval(currentPhase.duration)
                print("⏱️ Added \(currentPhase.duration)s for '\(currentPhase.name)' → New cumulative delay: \(cumulativeDelay)s")
            }
            
            print("\n--------------------------------------------------")
            print("✅ SUCCESS: Scheduled \(phases.count - 1) phase transition notifications")
            print("⏱️ Final cumulative delay: \(cumulativeDelay) seconds")
            print("--------------------------------------------------\n")
            
            // Debug: Print all pending notifications
            printPendingNotifications()
        }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑️ All pending notifications have been canceled.")
    }
    
    // Debug helper to list all pending notifications
    func printPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("\n📋 PENDING NOTIFICATIONS (\(requests.count))")
            requests.forEach { request in
                if let trigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                    let triggerTime = Date().addingTimeInterval(trigger.timeInterval)
                    let formatter = DateFormatter()
                    formatter.timeStyle = .medium
                    formatter.dateStyle = .short
                    
                    print("""
                      - ID: \(request.identifier)
                        Title: \(request.content.title)
                        Body: \(request.content.body)
                        Trigger: \(trigger.timeInterval)s from now
                        Trigger at: \(formatter.string(from: triggerTime))
                      """)
                }
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .list])
    }
}

