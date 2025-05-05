import SwiftUI

struct NewFeatureView: View {
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                NotificationManager.instance.requestAuthorization()
                NotificationManager.instance.sendTestNotification()
            }) {
                Text(LocalizedStringKey("new_feature_title"))
                    .font(.body)
                    .frame(maxWidth: .infinity)
            }
            .padding(8)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    NewFeatureView()
}
