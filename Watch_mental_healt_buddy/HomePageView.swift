import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var icon: String
}

struct HomePageView: View {
    @ObservedObject var sleepDataManager = SleepDataManager()
    @StateObject var attackManager = AttackManager.shared

    @State private var cards = [
        CardData(title: "Tip", description: "Take 5 min to breathe today", icon: "lamp"),
        CardData(title: "Chance of Panic Attack", description: "Unlikely", icon: "question"),
        CardData(title: "Sleep", description: "This is the third card.", icon: "moon"),
    ]

    var body: some View {
        ZStack {
            // Background color
            Style.StyleColor.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // Header text
                Text("Summary")
                    .font(Style.Text.title1)
                    .foregroundColor(Style.StyleColor.textPrimary)
                    .padding(.leading)

                // Image with text overlay
                ZStack {
                    Image("stok")
                        .resizable()
                        .frame(height: 232)

                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 232)
                    .cornerRadius(10)

                    Text("You are doing fine!")
                        .font(Style.Text.title1)
                        .foregroundColor(Style.StyleColor.white)
                        .offset(y: 60)
                }
                .cornerRadius(10)

                // Clickable cards
                VStack(spacing: 8) {
                    ForEach($cards) { $card in
                        Button(action: {
                            print("\(card.title) clicked")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) { // HStack voor icoon en titel
                                    Image(card.icon) // Vervang door je eigen icoon
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
            NotificationManager.instance.requestAuthorization()
            attackManager.startMonitoring()
            print("AttackManager started monitoring")
            
            // Update the second card's description
            if let sleepData = sleepDataManager.sleepData {
                if !sleepData.status.isEmpty {
                    // Using the correct index to update the card
                    $cards[2].description.wrappedValue = sleepData.status
                } else {
                    let sleepDescription = "\(sleepData.hours) hr \(sleepData.minutes) min"
                    $cards[2].description.wrappedValue = sleepDescription
                }
            } else {
                $cards[2].description.wrappedValue = "Loading..."
            }
            
            if !attackManager.panicRiskStatus.isEmpty {
                // Using the correct index to update the card
                $cards[1].description.wrappedValue = attackManager.panicRiskStatus
            } else {
                $cards[1].description.wrappedValue = "Loading..."
            }
        }
    }
}

#Preview {
    HomePageView()
}
