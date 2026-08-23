import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Welcome Header
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to ArabConnect")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Connect with community resources and services for newcomers in Canada.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    
                    // MARK: - Community Posts
                    
                    NavigationLink(destination: ViewPostsView()) {
                        HomeCard(
                            icon: "person.3.fill",
                            title: "Community Posts",
                            subtitle: "View and share posts from the community."
                        )
                    }
                    
                    
                    // MARK: - Jobs
                    
                    NavigationLink(destination: JobsView()) {
                        HomeCard(
                            icon: "briefcase.fill",
                            title: "Jobs",
                            subtitle: "Find employment opportunities and job resources."
                        )
                    }
                    
                    
                    // MARK: - Housing
                    
                    NavigationLink(destination: HousingView()) {
                        HomeCard(
                            icon: "house.fill",
                            title: "Housing",
                            subtitle: "Find housing information and resources."
                        )
                    }
                    
                    
                    // MARK: - Healthcare
                    
                    NavigationLink(destination: HealthcareView()) {
                        HomeCard(
                            icon: "cross.case.fill",
                            title: "Healthcare",
                            subtitle: "Access healthcare information and services."
                        )
                    }
                    
                    
                    // MARK: - Education
                    
                    NavigationLink(destination: EducationView()) {
                        HomeCard(
                            icon: "book.fill",
                            title: "Education",
                            subtitle: "Explore education and learning resources."
                        )
                    }
                    
                    
                    // MARK: - Government Programs
                    
                    NavigationLink(destination: GovernmentProgramsView()) {
                        HomeCard(
                            icon: "building.columns.fill",
                            title: "Government Programs",
                            subtitle: "Explore government programs and newcomer services."
                        )
                    }
                    
                    
                    // MARK: - Newcomer Rights
                    
                    NavigationLink(destination: RightsView()) {
                        HomeCard(
                            icon: "checkmark.shield.fill",
                            title: "Newcomer Rights",
                            subtitle: "Learn about your rights and available support."
                        )
                    }
                    
                    
                    // MARK: - Profile
                    
                    NavigationLink(destination: ProfileView()) {
                        HomeCard(
                            icon: "person.crop.circle.fill",
                            title: "My Profile",
                            subtitle: "View and manage your profile."
                        )
                    }
                    
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


// MARK: - Home Card

struct HomeCard: View {
    
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 45, height: 45)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
}


// MARK: - Preview

#Preview {
    HomeView()
}
