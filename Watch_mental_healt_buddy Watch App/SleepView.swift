import SwiftUI

struct SleepView: View {

    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let iconSize = width * 0.5
            let textSize = width * 0.15
            let padding = width * 0.1
            
            ZStack {
                Color(red: 61/255, green: 8/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack(spacing: padding) {
                    Image(systemName: "moon.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    Text("sleep_view_text")
                        .font(.system(size: textSize, weight: .black))
                        .foregroundColor(Color.white)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    SleepView()
}
