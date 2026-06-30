import SwiftUI
import FirebaseAuth

struct HomeView: View {

    var body: some View {

        VStack(spacing: 25) {

            Text("🏠")
                .font(.system(size: 80))

            Text("Welcome to ArabConnect")
                .font(.largeTitle)
                .bold()

            if let user = Auth.auth().currentUser {

                Text(user.email ?? "")
                    .foregroundColor(.gray)

            }

            Spacer()

        }
        .padding()
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
