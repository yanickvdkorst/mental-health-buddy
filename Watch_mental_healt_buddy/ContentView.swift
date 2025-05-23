import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                HomePageView()
                    .tabItem {
                        Image("home")
                        Text("Home")
                    }
//                HeartRateView()
//                    .tabItem {
//                        Image(systemName: "heart.fill")
//                        Text("Heart Rate")
//                    }
//                SleepView()
//                    .tabItem {
//                        Image(systemName: "bed.double.fill")
//                        Text("Sleep View")
//                    }
                ExtraPageView()
                    .tabItem {
                        Image("dots")
                        Text("More")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
