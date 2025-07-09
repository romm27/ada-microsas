//
//  NotificationManager.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 09/07/25.
//

// MARK: - FILENAME: ada-microsas/ada-microsas/ViewModel/NotificationManager.swift

import UserNotifications

/// A singleton class to manage all local notification logic for the app.
/// This class handles requesting permission, scheduling notifications for an entire workout,
/// and canceling/rescheduling them when the workout is interrupted (paused, stopped, or completed).
class NotificationManager {
    /// The shared singleton instance of the manager.
    static let shared = NotificationManager()
    
    /// Private initializer to enforce the singleton pattern.
    private init() {}

    /// Requests user authorization to send notifications.
    /// This should be called once when the app is likely to need notifications, such as on the main screen's appearance.
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
    
    /// Schedules all notifications for a workout at the very beginning.
    /// This should be called only when a new workout starts.
    /// - Parameter workout: The `WorkoutPlan` containing all phases for the session.
    func scheduleWorkoutNotifications(for workout: WorkoutPlan) {
        scheduleNotifications(for: workout.allPhases, initialPhaseRemainingTime: nil, isResuming: false)
    }

    /// Re-schedules notifications when a workout is resumed after being paused.
    /// This is critical because the original timeline is void after a pause.
    /// It calculates new trigger times based on the remaining time in the current phase and the full duration of all subsequent phases.
    /// - Parameter remainingPhases: An array of `ActivityPhase` including the current (partially completed) one and all subsequent ones.
    /// - Parameter currentTime: The time left on the timer for the *current* phase when it was paused.
    func rescheduleNotificationsOnResume(remainingPhases: [ActivityPhase], currentTime: Int) {
        scheduleNotifications(for: remainingPhases, initialPhaseRemainingTime: currentTime, isResuming: true)
    }

    /// Private helper function that contains the core scheduling logic. It's used for both
    /// initial scheduling and re-scheduling on resume.
    /// - Parameters:
    ///   - phases: The list of phases to schedule notifications for.
    ///   - initialPhaseRemainingTime: If resuming, this is the time left in the first phase of the `phases` array. If `nil`, the full duration is used.
    ///   - isResuming: A boolean flag for logging purposes.
    private func scheduleNotifications(for phases: [ActivityPhase], initialPhaseRemainingTime: Int?, isResuming: Bool) {
        // Always clear previous notifications before scheduling new ones to prevent duplicates.
        cancelAllNotifications()
        
        guard !phases.isEmpty else { return }

        var cumulativeTime: TimeInterval = 0
        
        // **This is the key logic for handling resume.**
        // For the very first phase in our list, use its remaining time if provided (on resume).
        // Otherwise (on a fresh start), use its full duration.
        if let remainingTime = initialPhaseRemainingTime {
            cumulativeTime = TimeInterval(remainingTime)
        } else {
            cumulativeTime = TimeInterval(phases.first?.duration ?? 0)
        }

        // Schedule the notification for the end of the *first* phase in the list.
        // This notification will announce the start of the second phase.
        if phases.count > 1 {
            let nextPhase = phases[1]
            scheduleSingleNotification(after: cumulativeTime, announcing: nextPhase)
        }
        
        // Now, loop through the *rest* of the phases to schedule their notifications.
        // We start at index 1 because we've already handled the first phase's timing.
        for index in 1..<phases.count - 1 {
            cumulativeTime += TimeInterval(phases[index].duration)
            let nextPhase = phases[index + 1]
            scheduleSingleNotification(after: cumulativeTime, announcing: nextPhase)
        }
        
        let action = isResuming ? "Rescheduled" : "Scheduled"
        // The number of notifications is always one less than the number of phases.
        let count = max(0, phases.count - 1)
        print("✅ \(action) \(count) notifications.")
    }
    
    /// Private helper to create and schedule a single notification, avoiding code duplication.
    private func scheduleSingleNotification(after delay: TimeInterval, announcing nextPhase: ActivityPhase) {
        let content = UNMutableNotificationContent()
        content.title = "Etapa concluída!"
        content.body = "Prepare-se para: \(nextPhase.name)."
        content.sound = UNNotificationSound(named: UNNotificationSoundName("finish_sound.caf"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        // Using a unique identifier prevents any potential conflicts.
        let request = UNNotificationRequest(identifier: "workout_phase_\(UUID().uuidString)", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
             if let error = error {
                 print("❌ Error scheduling notification for phase '\(nextPhase.name)': \(error.localizedDescription)")
             }
        }
    }
    
    /// Cancels all pending notifications that have been scheduled by this app.
    /// This should be called when a workout is paused, manually stopped/canceled, or successfully completed.
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑️ All pending notifications have been canceled.")
    }
}
