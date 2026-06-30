import SwiftUI

struct RightsView: View {

    let rights = [
        "Healthcare Rights",
        "Employment Rights",
        "Tenant Rights",
        "Human Rights Protection",
        "Education Access",
        "Emergency Services"
    ]

    var body: some View {

        List(rights, id: \.self) { right in

            VStack(alignment: .leading) {

                Text(right)
                    .font(.headline)

                Text("Important information for newcomers")
                    .foregroundColor(.gray)

            }

        }
        .navigationTitle("Newcomer Rights")
    }
}

#Preview {
    NavigationStack {
        RightsView()
    }
}
