import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "globe.americas.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text("ArabConnect")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Connecting Newcomers with Community Resources")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    SplashView()
}
