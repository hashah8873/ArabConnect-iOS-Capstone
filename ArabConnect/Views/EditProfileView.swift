import SwiftUI

struct EditProfileView: View {

    var body: some View {

        VStack(spacing: 20) {

            Text("Edit Profile")
                .font(.largeTitle)
                .bold()

            TextField("Full Name", text: .constant(""))
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: .constant(""))
                .textFieldStyle(.roundedBorder)

            Button("Save Changes") {

            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()

        }
        .padding()
    }
}

#Preview {
    EditProfileView()
}
