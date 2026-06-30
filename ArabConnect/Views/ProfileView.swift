import SwiftUI

struct ProfileView: View {

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)

            Text("User Profile")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Name: Hiba")
            Text("Email: user@email.com")

            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
