import SwiftUI

struct NewFeatureView: View {
    var body: some View {
        VStack {
            Text(LocalizedStringKey("new_feature_title"))
                .font(.largeTitle)
                .padding()
        }
        .padding()
    }
}

#Preview {
    NewFeatureView()
}
