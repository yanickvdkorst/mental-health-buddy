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
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { query, results, error in
            if let error = error {
                print("Error fetching sleep data: \(error.localizedDescription)")
                return
            }

            guard let results = results as? [HKCategorySample], !results.isEmpty else {
                print("No sleep data found")
                return
            }

            var totalSleepDuration: TimeInterval = 0
            for result in results {
                let sleepDuration = result.endDate.timeIntervalSince(result.startDate)
                totalSleepDuration += sleepDuration
                let hours = Int(sleepDuration) / 3600
                let minutes = (Int(sleepDuration) % 3600) / 60
                print("Fetched sleep data: \(hours) hours, \(minutes) minutes")
            }

            let averageSleepDuration = totalSleepDuration / Double(results.count)
            let averageHours = Int(averageSleepDuration) / 3600
            let averageMinutes = (Int(averageSleepDuration) % 3600) / 60
            print("Average sleep duration over the past day: \(averageHours) hours, \(averageMinutes) minutes")

            let latestResult = results.first!
            let latestSleepDuration = latestResult.endDate.timeIntervalSince(latestResult.startDate)
            let latestHours = Int(latestSleepDuration) / 3600
            let latestMinutes = (Int(latestSleepDuration) % 3600) / 60

            DispatchQueue.main.async {
                self.sleepData = SleepData(id: UUID(), hours: latestHours, minutes: latestMinutes)
            }
            #if DEBUG
                self.sleepData = SleepData(id: UUID(), hours: 7, minutes: 30)
            #endif

        }
        healthStore.execute(query)
    }
}
