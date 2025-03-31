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
            }
        }
    }
}

#Preview {
    ContentView()
}
