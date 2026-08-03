import SwiftUI

struct HomeView: View {

    var body: some View {

        NavigationStack {

            List {

                NavigationLink("Jobs", destination: JobsView())

                NavigationLink("Housing", destination: HousingView())

                NavigationLink("Healthcare", destination: HealthcareView())

                NavigationLink("Education", destination: EducationView())

                NavigationLink("Government Programs", destination: GovernmentProgramsView())

                NavigationLink("Newcomer Rights", destination: RightsView())

                NavigationLink("Community Posts", destination: ViewPostsView())

                NavigationLink("Add Post", destination: AddPostView())

                NavigationLink("Profile", destination: ProfileView())

            }

            .navigationTitle("ArabConnect")

        }

    }

}

#Preview {

    HomeView()

}
