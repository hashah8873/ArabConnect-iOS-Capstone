import SwiftUI

struct AddPostView: View {

    @State private var title = ""
    @State private var description = ""
    @State private var category = ""

    let postService = PostService()

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                Text("Create New Post")
                    .font(.largeTitle)
                    .bold()

                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)

                TextField("Category", text: $category)
                    .textFieldStyle(.roundedBorder)

                TextField("Description", text: $description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5)

                Button("Publish") {

                    postService.addPost(
                        title: title,
                        description: description,
                        category: category
                    ) { success in

                        if success {

                            print("✅ Post Saved Successfully")

                            title = ""
                            category = ""
                            description = ""

                        } else {

                            print("❌ Failed to Save Post")

                        }

                    }

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)

            }
            .padding()

        }
        .navigationTitle("Add Post")

    }

}

#Preview {

    NavigationStack {

        AddPostView()

    }

}
