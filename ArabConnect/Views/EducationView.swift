import SwiftUI

struct EducationView: View {

    let courses = [
        "English Language Classes",
        "College Preparation Program",
        "Computer Skills Training",
        "Community Workshops"
    ]

    var body: some View {

        List(courses, id: \.self) { course in

            VStack(alignment: .leading) {

                Text(course)
                    .font(.headline)

                Text("Educational resource")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Education")
    }
}

#Preview {
    NavigationStack {
        EducationView()
    }
}
