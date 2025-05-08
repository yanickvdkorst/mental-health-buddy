import SwiftUI

struct ExtraCardData: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var icon: String
}

struct ExtraPageView: View {
    @ObservedObject var connectivityManager = WatchConnectivityManager()
    @ObservedObject var sleepDataManager = SleepDataManager()

    @State private var cards = [
        ExtraCardData(title: "Heart Rate", description: "Take 5 min to breathe today", icon: "lamp"),
        ExtraCardData(title: "Sleep", description: "This is the third card.", icon: "moon"),
    ]

    var body: some View {
        ZStack {
            // Background color
            Style.StyleColor.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // Header text
                Text("Extra")
                    .font(Style.Text.title1)
                    .foregroundColor(Style.StyleColor.textPrimary)
                    .padding(.leading)

                // Image with text overlay
                ZStack {
                    Image("stok")
                        .resizable()
                        .frame(height: 140)

                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 140)
                    .cornerRadius(10)

                    Text("More Info")
                        .font(Style.Text.title1)
                        .foregroundColor(Style.StyleColor.white)
                }
                .cornerRadius(10)

                // Clickable cards
                VStack(spacing: 8) {
                    ForEach(cards) { card in
                        Button(action: {
                            print("\(card.title) clicked")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) {
                                    Image(card.icon)
                                        .resizable()
                                        .frame(width: 20, height: 24)
                                    Text(card.title)
                                        .font(Style.Text.subheadline)
                                        .foregroundColor(Style.StyleColor.black)
                                }
                                Text(card.description)
                                    .font(Style.Text.body)
                                    .foregroundColor(Style.StyleColor.textThird)
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top)
        }
        .onAppear {
            sleepDataManager.requestAuthorization()

            // Update the heart rate card description
            cards[0].description = "\(String(format: "%.0f", connectivityManager.heartRate)) BPM"

            if let sleepData = sleepDataManager.sleepData {
                if !sleepData.status.isEmpty {
                    cards[1].description = sleepData.status
                } else {
                    let sleepDescription = "\(sleepData.hours) hr \(sleepData.minutes) min"
                    cards[1].description = sleepDescription
                }
            } else {
                cards[1].description = "Loading..."
            }
        }
    }
}

#Preview {
    ExtraPageView()
}
