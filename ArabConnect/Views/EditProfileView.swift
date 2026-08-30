import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var isSaving = false
    @State private var message = ""
    @State private var showSuccess = false
    
    private let db = Firestore.firestore()
    
    var body: some View {
        
        Form {
            
            Section("Personal Information") {
                
                TextField("Full Name", text: $fullName)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            
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
                    isSaving ||
                    fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
            
            
            if !message.isEmpty {
                
                Section {
                    Text(message)
                        .foregroundColor(showSuccess ? .green : .red)
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadCurrentUser()
        }
    }
    
    
    // MARK: - Load User
    
    private func loadCurrentUser() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            message = "No user is currently logged in."
            return
        }
        
        db.collection("users")
            .document(userID)
            .getDocument { snapshot, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        message = error.localizedDescription
                        return
                    }
                    
                    guard let data = snapshot?.data() else {
                        message = "User information was not found."
                        return
                    }
                    
                    fullName = data["fullName"] as? String ?? ""
                    email = data["email"] as? String ?? ""
                }
            }
    }
    
    
    // MARK: - Save Changes
    
    private func saveChanges() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            message = "No user is currently logged in."
            return
        }
        
        let cleanName = fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !cleanName.isEmpty else {
            message = "Please enter your full name."
            return
        }
        
        isSaving = true
        message = ""
        
        let updatedData: [String: Any] = [
            "fullName": cleanName
        ]
        
        db.collection("users")
            .document(userID)
            .updateData(updatedData) { error in
                
                DispatchQueue.main.async {
                    
                    isSaving = false
                    
                    if let error = error {
                        message = error.localizedDescription
                        showSuccess = false
                        return
                    }
                    
                    showSuccess = true
                    message = "Profile updated successfully!"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        dismiss()
                    }
                }
            }
    }
}


#Preview {
    NavigationStack {
        EditProfileView()
    }
}
