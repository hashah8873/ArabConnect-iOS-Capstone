import SwiftUI
import FirebaseAuth

struct RegisterView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""

    var body: some View {

        VStack(spacing: 20) {

            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("Full Name", text: $fullName)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.words)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button(action: {

                errorMessage = ""
                successMessage = ""

                guard !email.isEmpty,
                      !password.isEmpty,
                      !fullName.isEmpty else {

                    errorMessage = "Please fill in all fields."
                    return
                }

                Auth.auth().createUser(withEmail: email, password: password) { result, error in

                    if let error = error {

                        errorMessage = error.localizedDescription
                        return
                    }

                    successMessage = "Account created successfully!"
                    print("User Created Successfully")

                }

            }) {

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
    }
}

#Preview {

    NavigationStack {

        RegisterView()

    }

}
