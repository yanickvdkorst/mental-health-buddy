import Foundation

class AttackManager: ObservableObject {
    static let shared = AttackManager()

    let connectivityManager = WatchConnectivityManager()
    let sleepDataManager = SleepDataManager()

    @Published var heartRateLog: String = "Monitoring..."
    @Published var panicRiskStatus: String = "Normal"

    private var timer: Timer?

    init() {
        sleepDataManager.requestAuthorization()
        startMonitoring()
    }

    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.checkForPanicWarning()
        }
    }

    private func checkForPanicWarning() {
        let heartRate = connectivityManager.heartRate
        let sleepData = sleepDataManager.sleepData

        let sleepStatus = sleepData?.status ?? "Unknown"
        heartRateLog = "❤️ Heart Rate: \(heartRate) BPM — Sleep: \(sleepStatus)"

        print("[LOG] Monitoring: \(heartRateLog)")

        if heartRate > 90 && sleepStatus.lowercased().contains("poor") {
            panicRiskStatus = "⚠️ High Risk"
            NotificationManager.instance.sendCustomMessageToPhone("⚠️ High heart rate and poor sleep detected.")
        } else {
            panicRiskStatus = "✅ Low Risk"
        }

        print("[LOG] Panic Risk Status: \(panicRiskStatus)")
    }
}
