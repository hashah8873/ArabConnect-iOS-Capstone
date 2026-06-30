import SwiftUI

struct HealthcareView: View {

    let healthcareServices = [
        "Family Doctor Clinic",
        "Walk-In Clinic",
        "Dental Care Services",
        "Mental Health Support"
    ]

    var body: some View {

        List(healthcareServices, id: \.self) { service in

            VStack(alignment: .leading) {

                Text(service)
                    .font(.headline)

                Text("Healthcare resource")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Healthcare")
    }
}

#Preview {
    NavigationStack {
        HealthcareView()
    }
}
