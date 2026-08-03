import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {

    @Published var user: User?

    let userService = UserService()

    func fetchUser() {

        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }

        userService.fetchUser(userID: userID) { user in
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
}
