import SwiftUI
import FirebaseAuth

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var navigateToHome = false

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {

                    errorMessage = ""

                    guard !email.isEmpty,
                          !password.isEmpty else {

                        errorMessage = "Please enter your email and password."
                        return
                    }

                    Auth.auth().signIn(withEmail: email, password: password) { result, error in

                        if let error = error {

                            errorMessage = error.localizedDescription
                            return
                        }

                        navigateToHome = true

                    }

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                if !errorMessage.isEmpty {

                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)

                }

                NavigationLink(
                    destination: HomeView(),
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }

                Spacer()

            }
            .padding()
            .navigationTitle("Login")

        }

    }
}

#Preview {
    LoginView()
}
