import SwiftUI

struct HeartRateView: View {
    @ObservedObject var connectivityManager = WatchConnectivityManager()

    @State private var heartIconScale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let iconSize = width * 0.5
            let titleSize = width * 0.15
            let textSize = width * 0.1
            let padding = width * 0.1

            ZStack {
                Color(red: 51/255, green: 0/255, blue: 0/255)
                    .ignoresSafeArea()

                VStack(spacing: padding) {
                    Text("Current Heart Rate")
                        .font(.system(size: textSize, weight: .black))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)

                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color(red: 177/255, green: 25/255, blue: 25/255))
                        .scaleEffect(heartIconScale)
                        .animation(
                            .easeInOut(duration: 0.2)
                            .repeatCount(1, autoreverses: true), value: heartIconScale)

                    Text("\(connectivityManager.heartRate, specifier: "%.0f") BPM")
                        .font(.system(size: titleSize, weight: .black))
                        .foregroundColor(Color.white)
                }
                .frame(width: width, height: height)
            }
            .onChange(of: connectivityManager.heartRate) { newValue in
                heartIconScale = 1.2
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    heartIconScale = 1.0
                }
            }
        }
    }
}

#Preview {
    HeartRateView()
}

