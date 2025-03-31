import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                HeartRateView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Heart Rate")
                    }
                NewFeatureView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("New Features")
                    }
                SleepView()
                    .tabItem {
                        Image(systemName: "bed.double.fill")
                        Text("Sleep View")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
