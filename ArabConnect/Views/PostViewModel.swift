import Foundation

class PostViewModel: ObservableObject {

    @Published var posts: [Post] = []

    let postService = PostService()

    func fetchPosts() {

        postService.fetchPosts { posts in

            DispatchQueue.main.async {

                self.posts = posts

            }

        }

    }

}
