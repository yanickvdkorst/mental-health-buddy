import SwiftUI
import HealthKit

struct SleepData: Identifiable {
    var id: UUID
    var hours: Int
    var minutes: Int
}

class SleepDataManager: ObservableObject {
    @Published var sleepData: SleepData?
    private var healthStore = HKHealthStore()

    func requestAuthorization() {
        print("Requesting authorization...")
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            if success {
                print("Authorization successful")
                self.fetchSleepData()
            } else {
                if let error = error {
                    print("Authorization failed with error: \(error.localizedDescription)")
                } else {
                    print("Authorization failed")
                }
            }
        }
    }

    func fetchSleepData() {
        print("fetchSleepData function called")
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { query, results, error in
            if let error = error {
                print("Error fetching sleep data: \(error.localizedDescription)")
                return
            }

            guard let result = results?.first as? HKCategorySample else {
                print("No sleep data found")
                return
            }

            let sleepDuration = result.endDate.timeIntervalSince(result.startDate)
            let hours = Int(sleepDuration) / 3600
            let minutes = (Int(sleepDuration) % 3600) / 60

            print("Fetched sleep data: \(hours) hours, \(minutes) minutes")

            DispatchQueue.main.async {
                self.sleepData = SleepData(id: UUID(), hours: hours, minutes: minutes)
            }
        }
        healthStore.execute(query)
    }
}
