import SwiftUI

struct HeartRateView: View {
    @StateObject private var heartRateManager = HeartRateManager()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let iconSize = width * 0.5
            let textSize = width * 0.15
            let padding = width * 0.1
            
            ZStack {
                Color(red: 51/255, green: 0/255, blue: 0/255)
                    .ignoresSafeArea()
                
                VStack(spacing: padding) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color(red: 177/255, green: 25/255, blue: 25/255))
                    
                    Text("\(Int(heartRateManager.heartRate)) BPM")
                        .font(.system(size: textSize, weight: .black))
                        .foregroundColor(Color.white)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    HeartRateView()
}
