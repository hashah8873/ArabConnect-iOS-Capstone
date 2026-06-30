import SwiftUI

struct HousingView: View {

    let housingOptions = [
        "Apartment Rental - Toronto",
        "Basement Apartment - Mississauga",
        "Shared Accommodation - Brampton",
        "Student Housing - Ottawa"
    ]

    var body: some View {

        List(housingOptions, id: \.self) { home in

            VStack(alignment: .leading) {

                Text(home)
                    .font(.headline)

                Text("Available housing option")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Housing")
    }
}

#Preview {
    NavigationStack {
        HousingView()
    }
}
