import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 25) {
                
                // MARK: - Profile Image
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                
                // MARK: - Profile Information
                
                VStack(spacing: 8) {
                    
                    Text(viewModel.user?.fullName ?? "User")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(viewModel.user?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                
                // MARK: - User Information Card
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading) {
                            
                            Text("Full Name")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(viewModel.user?.fullName ?? "")
                                .font(.body)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading) {
                            
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(viewModel.user?.email ?? "")
                                .font(.body)
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                
                // MARK: - Edit Profile
                
                NavigationLink(destination: EditProfileView()) {
                    
                    HStack {
                        
                        Image(systemName: "pencil")
                        
                        Text("Edit Profile")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                
                
                // MARK: - Logout
                
                Button {
                    
                    logout()
                    
                } label: {
                    
                    HStack {
                        
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        
                        Text("Logout")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                
                
                Spacer(minLength: 30)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    
    // MARK: - Logout
    
    private func logout() {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch {
            
            print("Logout error: \(error.localizedDescription)")
        }
    }
}


#Preview {
    NavigationStack {
        ProfileView()
    }
}
