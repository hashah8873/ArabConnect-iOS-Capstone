import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 25) {

            Image(systemName: "globe.americas.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text("Welcome to ArabConnect")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Helping Arabic-speaking newcomers connect with resources, services, and opportunities across Canada.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            NavigationLink(destination: LoginView()) {

                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)

            }

            NavigationLink(destination: RegisterView()) {

                Text("Create Account")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 2)
                    )
            }

        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}
