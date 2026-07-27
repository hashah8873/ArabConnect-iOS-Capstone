import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""
    @State private var navigateToHome = false

    let db = Firestore.firestore()

    var body: some View {

        VStack(spacing: 20) {

            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("Full Name", text: $fullName)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button {

                errorMessage = ""
                successMessage = ""

                guard !fullName.isEmpty,
                      !email.isEmpty,
                      !password.isEmpty else {

                    errorMessage = "Please fill in all fields."
                    return
                }

                Auth.auth().createUser(withEmail: email, password: password) { result, error in

                    if let error = error {

                        print("Firebase Error: \(error)")
                        print("Localized Description: \(error.localizedDescription)")

                        errorMessage = error.localizedDescription
                        return
                    }

                    guard let userID = result?.user.uid else {
                        return
                    }

                    db.collection("users").document(userID).setData([

                        "fullName": fullName,
                        "email": email,
                        "createdAt": Timestamp()

                    ]) { error in

                        if let error = error {

                            errorMessage = error.localizedDescription
                            return

                        }

                        successMessage = "Account created successfully!"
                        navigateToHome = true

                        print("User Created Successfully")

                    }
                }

            } label: {

                Text("Create Account")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)

            }

            if !successMessage.isEmpty {

                Text(successMessage)
                    .foregroundColor(.green)

            }

            if !errorMessage.isEmpty {

                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)

            }

            Spacer()

        }
        .padding()
        .navigationTitle("Register")
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }

    }
}

#Preview {

    NavigationStack {
        RegisterView()
    }

}
