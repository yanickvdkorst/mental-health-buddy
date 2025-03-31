import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    private var session: WCSession?
    
    @Published var heartRate: Double = 0.0
    
    override init() {
        super.init()
        
        // Start de sessie bij het initiëren
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    // MARK: - WCSessionDelegate methods
    
    // Called when data is received from the watchOS app
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let heartRateValue = message["heartRate"] as? Double {
            DispatchQueue.main.async {
                self.heartRate = heartRateValue
            }
        }
    }
    
    // Handle other delegate methods as needed, for example, errors or state changes
    func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Error activating WCSession: \(error.localizedDescription)")
        } else {
            print("WCSession activated successfully.")
        }
    }
    
    // Handle session did receive message when the watch is reachable
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
}
