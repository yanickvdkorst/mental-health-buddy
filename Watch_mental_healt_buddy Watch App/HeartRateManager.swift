import Foundation
import HealthKit
import WatchConnectivity

class HeartRateManager: NSObject, ObservableObject, WCSessionDelegate {
    private var healthStore = HKHealthStore()
    private var query: HKObserverQuery?
    private var session: WCSession?
    private var timer: Timer?
    
    // List to store the last 5 heart rate measurements
    private var heartRateHistory: [Double] = []

    @Published var heartRate: Double = 0.0

    override init() {
        super.init()
        requestAuthorization()
        setupWatchConnectivity()
    }
    
    private func setupWatchConnectivity() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    private func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data is not available on this device.")
            return
        }

        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.startHeartRateQuery()
                    self.startTimer()  // Start the timer to request heart rate every 5 seconds
                }
            } else {
                print("Authorization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    private func startHeartRateQuery() {
        // Define the heart rate type
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        // Create the observer query to watch for heart rate changes
        query = HKObserverQuery(sampleType: heartRateType, predicate: nil) { [weak self] (query, completionHandler, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error in observer query: \(error.localizedDescription)")
                return
            }
            
            // Fetch the most recent heart rate sample when the data is updated
            self.fetchLatestHeartRateSample()
            
            // Call completionHandler to continue listening for updates
            completionHandler()
        }
        
        // Execute the observer query
        if let query = query {
            healthStore.execute(query)
        }
    }
    
    private func fetchLatestHeartRateSample() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        
        // Query to get the latest heart rate sample
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { [weak self] (query, samples, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching heart rate sample: \(error.localizedDescription)")
                return
            }
            
            guard let sample = samples?.first as? HKQuantitySample else { return }
            
            let bpmUnit = HKUnit(from: "count/min")
            let value = sample.quantity.doubleValue(for: bpmUnit)
            
            DispatchQueue.main.async {
                // Add the new heart rate to the history
                self.addHeartRateMeasurement(value)
                
                // Calculate the average and update the heart rate
                self.heartRate = self.calculateAverageHeartRate()
//                print("Average Heart Rate: \(self.heartRate) BPM")
                
                // Send the heart rate to the iOS app using Watch Connectivity
                self.sendHeartRateToPhone(self.heartRate)
            }
        }
        
        // Execute the query
        healthStore.execute(query)
    }
    
    private func addHeartRateMeasurement(_ value: Double) {
        // Add the new value to the heart rate history
        heartRateHistory.append(value)
        
        // Ensure the history contains at most 5 values
        if heartRateHistory.count > 5 {
            heartRateHistory.removeFirst()
        }
    }
    
    private func calculateAverageHeartRate() -> Double {
        // Calculate the average of the last 5 heart rate measurements
        let sum = heartRateHistory.reduce(0, +)
        return sum / Double(heartRateHistory.count)
    }
    
    // Send heart rate data to iOS app
    private func sendHeartRateToPhone(_ heartRate: Double) {
        if let session = session, session.isReachable {
            session.sendMessage(["heartRate": heartRate], replyHandler: nil, errorHandler: { error in
                print("Error sending heart rate to iOS app: \(error.localizedDescription)")
            })
        }
    }
    
    // MARK: - Timer to fetch heart rate every 5 seconds
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fetchHeartRate), userInfo: nil, repeats: true)
    }
    
    @objc private func fetchHeartRate() {
        // Fetch the latest heart rate sample every 5 seconds
        fetchLatestHeartRateSample()
    }
    
    // MARK: - WCSessionDelegate methods
    
    func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Error activating WCSession: \(error.localizedDescription)")
        } else {
            print("WCSession activated successfully.")
        }
    }
}
