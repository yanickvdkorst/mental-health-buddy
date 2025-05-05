import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting authorization: \(error)")
            } else {
                print("Authorization granted: \(granted)")
            }
        }
    }

    func sendNotificationToPhone() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notifications are not authorized")
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "iPhone Notification"
            content.body = "This is a notification sent to your iPhone."
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            print("Attempting to send notification to iPhone...")
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending notification: \(error)")
                } else {
                    print("Notification sent successfully to iPhone.")
                }
            }
        }
    }
}
