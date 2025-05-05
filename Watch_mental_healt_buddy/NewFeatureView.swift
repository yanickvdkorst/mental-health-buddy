import SwiftUI

struct NewFeatureView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("new_feature_title"))
                .font(.largeTitle)
                .padding()

            Button("Stuur Melding") {
                NotificationManager.instance.requestAuthorization()
                NotificationManager.instance.sendTestNotification()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
}

#Preview {
    NewFeatureView()
}
