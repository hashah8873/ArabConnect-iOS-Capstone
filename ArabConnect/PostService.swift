import Foundation
import FirebaseAuth
import FirebaseFirestore

class PostService {

    let db = Firestore.firestore()

    // إضافة منشور
    func addPost(
        title: String,
        description: String,
        category: String,
        completion: @escaping (Bool) -> Void
    ) {

        guard let userID = Auth.auth().currentUser?.uid else {
            print("❌ No logged in user")
            completion(false)
            return
        }

        let postID = UUID().uuidString

        db.collection("posts").document(postID).setData([

            "title": title,
            "description": description,
            "category": category,
            "createdBy": userID,
            "createdAt": Timestamp(date: Date())

        ]) { error in

            if let error = error {

                print("❌ Firestore Error: \(error.localizedDescription)")
                completion(false)

            } else {

                print("✅ Post Saved")
                completion(true)

            }

        }

    }

    // جلب جميع المنشورات
    func fetchPosts(completion: @escaping ([Post]) -> Void) {

        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in

                if let error = error {
                    print("❌ Fetch Error: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let posts = documents.map { document in

                    let data = document.data()

                    return Post(
                        id: document.documentID,
                        title: data["title"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        category: data["category"] as? String ?? "",
                        createdBy: data["createdBy"] as? String ?? "",
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )

                }

                completion(posts)

            }

    }

}
