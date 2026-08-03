import SwiftUI

struct SplashView: View {

    @State private var goToWelcome = false

    var body: some View {

        if goToWelcome {

            ContentView()

        } else {

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
            .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                    goToWelcome = true

                }

            }

        }

    }

}

#Preview {

    SplashView()

}
