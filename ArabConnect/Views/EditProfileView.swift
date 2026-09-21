import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditProfileView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var email = ""

    @State private var isLoading = true
    @State private var isSaving = false

    @State private var errorMessage = ""
    @State private var successMessage = ""

    private let db = Firestore.firestore()

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Profile Information

                Section("Profile Information") {

                    TextField("Full Name", text: $fullName)
                        .textContentType(.name)
                        .autocorrectionDisabled()

                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }

                // MARK: - Save Button

                Section {

                    Button {
                        saveChanges()
                    } label: {

                        HStack {

                            Spacer()

                            if isSaving {
                                ProgressView()
                            } else {
                                Text("Save Changes")
                                    .fontWeight(.semibold)
                            }

                            Spacer()
                        }
                    }
                    .disabled(
                        isLoading ||
                        isSaving ||
                        fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }

                // MARK: - Messages

                if !errorMessage.isEmpty {

                    Section {

                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                }

                if !successMessage.isEmpty {

                    Section {

                        Text(successMessage)
                            .foregroundColor(.green)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("Cancel") {
                        dismiss()
                    }
                }
            }

            .onAppear {
                loadUserProfile()
            }
        }
    }

    // MARK: - Load User Profile

    private func loadUserProfile() {

        isLoading = true
        errorMessage = ""

        guard let user = Auth.auth().currentUser else {

            isLoading = false
            errorMessage = "No user is currently logged in."
            return
        }

        let userID = user.uid

        db.collection("users")
            .document(userID)
            .getDocument { document, error in

                DispatchQueue.main.async {

                    isLoading = false

                    if let error = error {

                        errorMessage =
                            "Failed to load profile: \(error.localizedDescription)"

                        return
                    }

                    guard let data = document?.data() else {

                        fullName = ""
                        email = user.email ?? ""

                        return
                    }

                    fullName = data["fullName"] as? String ?? ""
                    email = data["email"] as? String ?? user.email ?? ""
                }
            }
    }

    // MARK: - Save Changes

    private func saveChanges() {

        errorMessage = ""
        successMessage = ""

        let trimmedName =
            fullName.trimmingCharacters(in: .whitespacesAndNewlines)

        let trimmedEmail =
            email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else {

            errorMessage = "Please enter your full name."
            return
        }

        guard !trimmedEmail.isEmpty else {

            errorMessage = "Please enter your email address."
            return
        }

        guard let user = Auth.auth().currentUser else {

            errorMessage = "No user is currently logged in."
            return
        }

        isSaving = true

        let userID = user.uid

        let updatedData: [String: Any] = [

            "fullName": trimmedName,
            "email": trimmedEmail
        ]

        db.collection("users")
            .document(userID)
            .updateData(updatedData) { error in

                DispatchQueue.main.async {

                    if let error = error {

                        isSaving = false

                        errorMessage =
                            "Failed to save changes: \(error.localizedDescription)"

                        return
                    }

                    // Update Firebase Authentication email
                    if trimmedEmail != user.email {

                        user.updateEmail(to: trimmedEmail) { error in

                            DispatchQueue.main.async {

                                isSaving = false

                                if let error = error {

                                    errorMessage =
                                        "Profile saved, but the authentication email could not be updated: \(error.localizedDescription)"

                                    return
                                }

                                successMessage =
                                    "Profile updated successfully."

                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 1.0
                                ) {
                                    dismiss()
                                }
                            }
                        }

                    } else {

                        isSaving = false

                        successMessage =
                            "Profile updated successfully."

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 1.0
                        ) {
                            dismiss()
                        }
                    }
                }
            }
    }
}

#Preview {
    EditProfileView()
}
