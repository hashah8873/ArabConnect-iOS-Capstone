import SwiftUI

struct ViewPostsView: View {

    @StateObject private var viewModel = PostViewModel()

    var body: some View {

        List(viewModel.posts) { post in

            VStack(alignment: .leading, spacing: 10) {

                Text(post.title)
                    .font(.headline)

                Text(post.category)
                    .foregroundColor(.blue)

                Text(post.description)

            }
            .padding(.vertical, 8)

        }
        .navigationTitle("Community Posts")
        .onAppear {

            viewModel.fetchPosts()

        }

    }

}

#Preview {

    NavigationStack {

        ViewPostsView()

    }

}
