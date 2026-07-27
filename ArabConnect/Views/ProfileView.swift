import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {

    @State private var fullName = ""
    @State private var email = ""

    let db = Firestore.firestore()

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)

            Text("User Profile")
                .font(.largeTitle)
                .bold()

            Text("Name: \(fullName)")
                .font(.title3)

            Text("Email: \(email)")
                .foregroundColor(.gray)

            Spacer()

            Button("Logout") {

                do {

                    try Auth.auth().signOut()

                } catch {

                    print(error.localizedDescription)

                }

            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)

        }
        .padding()
        .navigationTitle("Profile")
        .onAppear {

            loadUser()

        }

    }

    func loadUser() {

        guard let uid = Auth.auth().currentUser?.uid else {

            return

        }

        db.collection("users")
            .document(uid)
            .getDocument { snapshot, error in

                guard let data = snapshot?.data() else {

                    return

                }

                fullName = data["fullName"] as? String ?? ""
                email = data["email"] as? String ?? ""

            }

    }

}

#Preview {

    NavigationStack {

        ProfileView()

    }

}
