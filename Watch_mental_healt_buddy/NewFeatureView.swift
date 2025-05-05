import SwiftUI

struct NewFeatureView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("New Feature")
                .font(.largeTitle)
                .padding()

            Button("Request Notification Authorization") {
                NotificationManager.instance.requestAuthorization()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())

            Button("Send Notification to Phone") {
                NotificationManager.instance.sendNotificationToPhone()
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
