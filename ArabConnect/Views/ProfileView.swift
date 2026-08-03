import SwiftUI
import FirebaseAuth

struct ProfileView: View {

    @StateObject private var viewModel = UserViewModel()

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)

            Text("User Profile")
                .font(.largeTitle)
                .bold()

            Text("Name: \(viewModel.user?.fullName ?? "")")
                .font(.title3)

            Text("Email: \(viewModel.user?.email ?? "")")
                .foregroundColor(.gray)

            NavigationLink(destination: EditProfileView()) {

                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

            }

            Button("Logout") {

                do {

                    try Auth.auth().signOut()

                } catch {

                    print(error.localizedDescription)

                }

            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()

        }
        .padding()
        .navigationTitle("Profile")
        .onAppear {

            viewModel.fetchUser()

        }

    }

}

#Preview {

    NavigationStack {

        ProfileView()

    }

}
