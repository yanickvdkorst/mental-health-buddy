import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HeartRateView()
                .tabItem {
                    Text("Heart Rate")
                }
            NewFeatureView()
                .tabItem {
                    Text("New Features")
                }
            SleepView()
                .tabItem {
                    Text("Sleep View")
                }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    ContentView()
}
