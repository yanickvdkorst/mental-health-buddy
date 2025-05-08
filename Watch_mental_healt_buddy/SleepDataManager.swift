import SwiftUI
import HealthKit

struct SleepData: Identifiable {
    var id: UUID
    var hours: Int
    var minutes: Int
    var status: String
}

class SleepDataManager: ObservableObject {
    @Published var sleepData: SleepData?
    private var healthStore = HKHealthStore()

    func requestAuthorization() {
        print("Requesting authorization from Watch...")
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            if success {
                print("Authorization successful on Watch")
                self.fetchSleepData()
            } else {
                if let error = error {
                    print("Authorization failed with error on Watch: \(error.localizedDescription)")
                } else {
                    print("Authorization failed on Watch")
                }
            }
        }
    }

    func fetchSleepData() {
        print("fetchSleepData function called")
        
        // Set initial status to indicate fetching
        DispatchQueue.main.async {
            self.sleepData = SleepData(id: UUID(), hours: 0, minutes: 0, status: "Fetching sleep data...")
        }
        
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: calendar.date(byAdding: .day, value: -1, to: now)!)!
        let endDate = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now)!

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { query, results, error in
            if let error = error {
                print("Error fetching sleep data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.sleepData = SleepData(id: UUID(), hours: 0, minutes: 0, status: "Error: \(error.localizedDescription)")
                }
                return
            }

            guard let results = results as? [HKCategorySample], !results.isEmpty else {
                print("No sleep data found")
                DispatchQueue.main.async {
                    self.sleepData = SleepData(id: UUID(), hours: 0, minutes: 0, status: "No sleep data found")
                }
                return
            }

            var totalSleepDuration: TimeInterval = 0
            for result in results {
                let sleepDuration = result.endDate.timeIntervalSince(result.startDate)
                totalSleepDuration += sleepDuration
            }

            let totalHours = Int(totalSleepDuration) / 3600
            let totalMinutes = (Int(totalSleepDuration) % 3600) / 60
            print("Total sleep duration over the past night: \(totalHours) hours, \(totalMinutes) minutes")
            
            DispatchQueue.main.async {
                self.sleepData = SleepData(id: UUID(), hours: totalHours, minutes: totalMinutes, status: "")
            }
        }
        healthStore.execute(query)
    }
}
