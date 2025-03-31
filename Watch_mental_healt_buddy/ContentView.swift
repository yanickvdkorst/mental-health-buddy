import SwiftUI

struct ContentView: View {
    @ObservedObject var connectivityManager = WatchConnectivityManager()
    
    // Add state for animating the heart icon size
    @State private var heartIconScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let iconSize = width * 0.5      // 50% van schermbreedte
            let titleSize = width * 0.15     // 15% van schermbreedte
            let textSize = width * 0.1
            let padding = width * 0.1       // 10% padding
            
            ZStack {
                Color(red: 51/255, green: 0/255, blue: 0/255)
                    .ignoresSafeArea()
                
                VStack(spacing: padding) {
                    Text("Current Heart Rate")
                        .font(.system(size: textSize, weight: .black))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    // Animate the heart icon scale
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color(red: 177/255, green: 25/255, blue: 25/255))
                        .scaleEffect(heartIconScale) // Apply the scale effect
                        .animation(
                            .easeInOut(duration: 0.2)
                            .repeatCount(1, autoreverses: true), value: heartIconScale) // Animate the scale

                    Text("\(connectivityManager.heartRate, specifier: "%.0f") BPM") // Update text with live heart rate
                        .font(.system(size: titleSize, weight: .black))
                        .foregroundColor(Color.white)
                }
                .frame(width: width, height: height)
            }
            // Trigger the scale effect whenever the heart rate updates
            .onChange(of: connectivityManager.heartRate) { newValue in
                heartIconScale = 1.2 // Increase the icon size temporarily
                // After a short delay, return to the normal size
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    heartIconScale = 1.0 // Reset the scale back to normal
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
