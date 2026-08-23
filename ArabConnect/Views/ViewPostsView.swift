import SwiftUI
import FirebaseFirestore

struct ViewPostsView: View {
    
    @State private var posts: [Post] = []
    @State private var isLoading = true
    @State private var errorMessage = ""
    
    private let db = Firestore.firestore()
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Loading posts...")
                        .padding()
                    
                } else if !errorMessage.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        
                        Text("Unable to load posts")
                            .font(.headline)
                        
                        Text(errorMessage)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button("Try Again") {
                            loadPosts()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    
                } else if posts.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "doc.text")
                            .font(.system(size: 50))
                        
                        Text("No Posts Yet")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Be the first person to create a post.")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                } else {
                    List {
                        ForEach(posts) { post in
                            PostRow(post: post)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        loadPosts()
                    }
                }
            }
            .navigationTitle("Community Posts")
            .onAppear {
                loadPosts()
            }
        }
    }
    
    // MARK: - Load Posts
    
    private func loadPosts() {
        isLoading = true
        errorMessage = ""
        
        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        isLoading = false
                        errorMessage = error.localizedDescription
                        return
                    }
                    
                    guard let documents = snapshot?.documents else {
                        isLoading = false
                        posts = []
                        return
                    }
                    
                    posts = documents.compactMap { document in
                        let data = document.data()
                        
                        guard
                            let title = data["title"] as? String,
                            let description = data["description"] as? String,
                            let category = data["category"] as? String,
                            let createdBy = data["createdBy"] as? String
                        else {
                            return nil
                        }
                        
                        let createdAt: Date
                        
                        if let timestamp = data["createdAt"] as? Timestamp {
                            createdAt = timestamp.dateValue()
                        } else {
                            createdAt = Date()
                        }
                        
                        return Post(
                            id: document.documentID,
                            title: title,
                            description: description,
                            category: category,
                            createdBy: createdBy,
                            createdAt: createdAt
                        )
                    }
                    
                    isLoading = false
                }
            }
    }
}

// MARK: - Post Row

struct PostRow: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(post.title)
                    .font(.headline)
                
                Spacer()
                
                Text(post.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.15))
                    .clipShape(Capsule())
            }
            
            Text(post.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Divider()
            
            HStack {
                Image(systemName: "person.circle")
                
                Text("Posted by user")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(post.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ViewPostsView()
}
