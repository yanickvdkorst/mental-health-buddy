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
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    ContentView()
}
