import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack {
            // Achtergrondkleur
            Style.StyleColor.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                // Tekst linksboven
                Text("Summary")
                    .font(Style.Text.title1)
                    .foregroundColor(Style.StyleColor.textPrimary)
                    .padding(.leading)
                
                // Afbeelding met tekst
                ZStack {
                    Image("stok") // Vervang dit met je eigen afbeelding
                        .resizable()
                        .frame(height: 232)

                    // Linear gradient
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
                        .offset(y: 60) // Verplaatst de tekst 20 punten naar beneden
                }
                .cornerRadius(10)
                
                // Klikbare kaarten
                VStack(spacing: 8) {
                    ForEach(1...3, id: \.self) { index in
                        Button(action: {
                            print("Card \(index) clicked")
                        }) {
                            Text("Card \(index)")
                                .font(Style.Text.body)
                                .foregroundColor(Style.StyleColor.textThird)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Style.StyleColor.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 16) // Padding links en rechts
            .padding(.top)
        }
    }
}

#Preview {
    HomePageView()
}
