import SwiftUI

struct SleepView: View {
    @ObservedObject var sleepDataManager = SleepDataManager()

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let iconSize = width * 0.5
            let titleSize = width * 0.15
            let textSize = width * 0.1
            let padding = width * 0.1

            ZStack {
                Color(red: 61/255, green: 8/255, blue: 52/255)
                    .ignoresSafeArea()

                VStack(spacing: padding) {
                    Text(LocalizedStringKey("sleep_view_title"))
                        .font(.system(size: titleSize, weight: .black))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)

                    Image(systemName: "moon.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))

                    if let sleepData = sleepDataManager.sleepData {
                        Text("\(sleepData.hours) hours \(sleepData.minutes) minutes")
                            .font(.system(size: textSize, weight: .black))
                            .foregroundColor(Color.white)
                    } else {
                        Text("Loading...")
                            .font(.system(size: textSize, weight: .black))
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: width, height: height)
            }
            .onAppear {
                print("SleepView appeared")
                sleepDataManager.requestAuthorization()
            }
        }
    }
}

#Preview {
    SleepView()
}
