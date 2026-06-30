import SwiftUI

struct GovernmentProgramsView: View {

    let programs = [
        "Ontario Health Insurance Plan (OHIP)",
        "Canada Child Benefit (CCB)",
        "Canada Dental Care Plan (CDCP)",
        "Ontario Works",
        "Employment Insurance (EI)",
        "Old Age Security (OAS)"
    ]

    var body: some View {

        List(programs, id: \.self) { program in

            VStack(alignment: .leading) {

                Text(program)
                    .font(.headline)

                Text("Government program information")
                    .foregroundColor(.gray)

            }

        }
        .navigationTitle("Government Programs")
    }
}

#Preview {
    NavigationStack {
        GovernmentProgramsView()
    }
}
