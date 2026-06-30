import SwiftUI

struct JobsView: View {

    let jobs = [
        "Cashier - Toronto",
        "Customer Service - Mississauga",
        "Warehouse Worker - Brampton",
        "Administrative Assistant - Ottawa"
    ]

    var body: some View {

        List(jobs, id: \.self) { job in

            VStack(alignment: .leading) {

                Text(job)
                    .font(.headline)

                Text("Entry level position")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Jobs")
    }
}

#Preview {
    NavigationStack {
        JobsView()
    }
}
