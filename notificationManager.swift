import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let instance = NotificationManager()
    private var lastNotificationDate: Date?

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

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
            content.title = "Heart Rate Alert"
            content.body = "Your heart rate is above 70 bpm!"
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending notification: \(error)")
                } else {
                    print("Notification sent successfully.")
                }
            }
        }
    }

    func checkHeartRate(heartRate: Int) {
         let currentDate = Date()
         let fiveMinutes: TimeInterval = 5 * 60

         if let lastDate = lastNotificationDate, currentDate.timeIntervalSince(lastDate) < fiveMinutes {
             print("Notification already sent recently. Waiting for 5 minutes.")
             return
         }

//         if heartRate > 70 {
//             print("Heart rate is above 70 bpm: \(heartRate)")
//             sendNotificationToPhone()
//             lastNotificationDate = currentDate
//         } else {
//             print("Heart rate is normal: \(heartRate)")
//         }
     }

    // Handle notifications when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func sendCustomMessageToPhone(_ message: String) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notifications not authorized.")
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "Warning"
            content.body = message
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending notification: \(error)")
                } else {
                    print("Custom panic alert sent.")
                }
            }
        }
    }

}


