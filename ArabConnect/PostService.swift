import Foundation
import FirebaseAuth
import FirebaseFirestore

class PostService {
    
    private let db = Firestore.firestore()
    
    // MARK: - Add Post
    
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
        
        let postData: [String: Any] = [
            "title": title,
            "description": description,
            "category": category,
            "createdBy": userID,
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("posts")
            .document(postID)
            .setData(postData) { error in
                
                if let error = error {
                    print("❌ Failed to save post: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("✅ Post saved successfully")
                    completion(true)
                }
            }
    }
    
    
    // MARK: - Fetch Posts
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        
        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("❌ Failed to fetch posts: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }
                
                let posts: [Post] = documents.compactMap { document in
                    
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
                
                print("✅ \(posts.count) posts loaded")
                completion(posts)
            }
    }
    
    
    // MARK: - Delete Post
    
    func deletePost(
        postID: String,
        completion: @escaping (Bool) -> Void
    ) {
        
        db.collection("posts")
            .document(postID)
            .delete { error in
                
                if let error = error {
                    print("❌ Failed to delete post: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("✅ Post deleted successfully")
                    completion(true)
                }
            }
    }
}
