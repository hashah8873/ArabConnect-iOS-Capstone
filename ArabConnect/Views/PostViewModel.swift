import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    private let postService = PostService()
    
    func loadPosts() {
        
        isLoading = true
        
        postService.fetchPosts { [weak self] posts in
            
            DispatchQueue.main.async {
                self?.posts = posts
                self?.isLoading = false
            }
        }
    }
    
    func deletePost(_ post: Post) {
        
        postService.deletePost(postID: post.id) { [weak self] success in
            
            if success {
                
                DispatchQueue.main.async {
                    self?.posts.removeAll { $0.id == post.id }
                }
            }
        }
    }
}
