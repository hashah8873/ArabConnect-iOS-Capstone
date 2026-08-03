import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService {

    let db = Firestore.firestore()

    func fetchUser(userID: String,
                   completion: @escaping (User?) -> Void) {

        db.collection("users")
            .document(userID)
            .getDocument { snapshot, error in

                guard let data = snapshot?.data(),
                      error == nil else {
                    completion(nil)
                    return
                }

                let user = User(
                    id: userID,
                    fullName: data["fullName"] as? String ?? "",
                    email: data["email"] as? String ?? ""
                )

                completion(user)
            }
    }
}
