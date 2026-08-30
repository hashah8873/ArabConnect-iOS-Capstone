import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ViewPostsView: View {
    
    @State private var posts: [Post] = []
    @State private var isLoading = true
    @State private var errorMessage = ""
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    private let db = Firestore.firestore()
    
    private let categories = [
        "All",
        "Job",
        "Housing",
        "Healthcare",
        "Education",
        "Other"
    ]
    
    // MARK: - Filtered Posts
    
    private var filteredPosts: [Post] {
        
        let search = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        return posts.filter { post in
            
            let matchesSearch: Bool
            
            if search.isEmpty {
                matchesSearch = true
            } else {
                matchesSearch =
                    post.title.lowercased().contains(search) ||
                    post.category.lowercased().contains(search) ||
                    post.description.lowercased().contains(search)
            }
            
            let matchesCategory: Bool
            
            if selectedCategory == "All" {
                matchesCategory = true
            } else {
                matchesCategory =
                    post.category.lowercased() ==
                    selectedCategory.lowercased()
            }
            
            return matchesSearch && matchesCategory
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                
                if isLoading {
                    
                    VStack(spacing: 15) {
                        
                        ProgressView()
                        
                        Text("Loading posts...")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                } else if !errorMessage.isEmpty {
                    
                    VStack(spacing: 15) {
                        
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("Unable to Load Posts")
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
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                } else if filteredPosts.isEmpty {
                    
                    VStack(spacing: 15) {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                        
                        Text("No Results")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("No posts match your search or selected category.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Clear Filters") {
                            searchText = ""
                            selectedCategory = "All"
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    
                } else {
                    
                    List {
                        
                        // MARK: - Category Filter
                        
                        Section {
                            
                            Picker(
                                "Category",
                                selection: $selectedCategory
                            ) {
                                
                                ForEach(
                                    categories,
                                    id: \.self
                                ) { category in
                                    
                                    Text(category)
                                        .tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                            
                        }
                        
                        // MARK: - Posts
                        
                        Section {
                            
                            ForEach(filteredPosts) { post in
                                
                                NavigationLink {
                                    
                                    PostDetailView(
                                        post: post,
                                        onPostUpdated: {
                                            loadPosts()
                                        },
                                        onPostDeleted: {
                                            loadPosts()
                                        }
                                    )
                                    
                                } label: {
                                    PostRow(post: post)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        loadPosts()
                    }
                }
            }
            .navigationTitle("Community Posts")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                prompt: "Search posts..."
            )
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
            
            HStack(alignment: .top) {
                
                Text(post.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(post.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.15))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
            }
            
            Text(post.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Divider()
            
            HStack {
                
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.blue)
                
                Text("Community Member")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(
                    post.createdAt.formatted(
                        date: .abbreviated,
                        time: .shortened
                    )
                )
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Post Detail View

struct PostDetailView: View {
    
    let post: Post
    let onPostUpdated: () -> Void
    let onPostDeleted: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showEditView = false
    @State private var showDeleteAlert = false
    @State private var isDeleting = false
    @State private var deleteError = ""
    
    private let db = Firestore.firestore()
    
    private var isOwner: Bool {
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return false
        }
        
        return currentUserID == post.createdBy
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    
                    Text(post.category)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.blue.opacity(0.15))
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Text(
                        post.createdAt.formatted(
                            date: .abbreviated,
                            time: .shortened
                        )
                    )
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                
                Divider()
                
                Text(post.description)
                    .font(.body)
                    .lineSpacing(5)
                
                Divider()
                
                HStack {
                    
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Posted by")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Community Member")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                }
                
                // MARK: - Owner Buttons
                
                if isOwner {
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            showEditView = true
                        } label: {
                            
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit Post")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete Post")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                if isDeleting {
                    
                    HStack {
                        ProgressView()
                        Text("Deleting post...")
                    }
                    .frame(maxWidth: .infinity)
                }
                
                if !deleteError.isEmpty {
                    
                    Text(deleteError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - Edit Sheet
        
        .sheet(isPresented: $showEditView) {
            
            EditPostView(
                post: post,
                onSaved: {
                    showEditView = false
                    onPostUpdated()
                    dismiss()
                }
            )
        }
        
        // MARK: - Delete Alert
        
        .alert(
            "Delete Post?",
            isPresented: $showDeleteAlert
        ) {
            
            Button("Cancel", role: .cancel) {
                
            }
            
            Button("Delete", role: .destructive) {
                deletePost()
            }
            
        } message: {
            Text(
                "Are you sure you want to delete this post? This action cannot be undone."
            )
        }
    }
    
    // MARK: - Delete Post
    
    private func deletePost() {
        
        guard isOwner else {
            deleteError = "You can only delete your own posts."
            return
        }
        
        isDeleting = true
        deleteError = ""
        
        db.collection("posts")
            .document(post.id)
            .delete { error in
                
                DispatchQueue.main.async {
                    
                    isDeleting = false
                    
                    if let error = error {
                        deleteError = error.localizedDescription
                        return
                    }
                    
                    onPostDeleted()
                    dismiss()
                }
            }
    }
}

// MARK: - Edit Post View

struct EditPostView: View {
    
    let post: Post
    let onSaved: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var category: String
    @State private var description: String
    
    @State private var isSaving = false
    @State private var errorMessage = ""
    
    private let db = Firestore.firestore()
    
    init(
        post: Post,
        onSaved: @escaping () -> Void
    ) {
        self.post = post
        self.onSaved = onSaved
        
        _title = State(initialValue: post.title)
        _category = State(initialValue: post.category)
        _description = State(initialValue: post.description)
    }
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Post Information") {
                    
                    TextField(
                        "Title",
                        text: $title
                    )
                    
                    TextField(
                        "Category",
                        text: $category
                    )
                    
                    TextField(
                        "Description",
                        text: $description,
                        axis: .vertical
                    )
                    .lineLimit(5...10)
                }
                
                Section {
                    
                    Button {
                        saveChanges()
                    } label: {
                        
                        HStack {
                            
                            Spacer()
                            
                            if isSaving {
                                ProgressView()
                            } else {
                                Text("Save Changes")
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                        }
                    }
                    .disabled(
                        isSaving ||
                        title.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty ||
                        category.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty ||
                        description.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                
                if !errorMessage.isEmpty {
                    
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Edit Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Save Changes
    
    private func saveChanges() {
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            errorMessage = "You must be logged in to edit a post."
            return
        }
        
        guard currentUserID == post.createdBy else {
            errorMessage = "You can only edit your own posts."
            return
        }
        
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        let cleanCategory = category.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        let cleanDescription = description.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !cleanTitle.isEmpty,
              !cleanCategory.isEmpty,
              !cleanDescription.isEmpty else {
            
            errorMessage = "Please complete all fields."
            return
        }
        
        isSaving = true
        errorMessage = ""
        
        let updatedData: [String: Any] = [
            "title": cleanTitle,
            "category": cleanCategory,
            "description": cleanDescription
        ]
        
        db.collection("posts")
            .document(post.id)
            .updateData(updatedData) { error in
                
                DispatchQueue.main.async {
                    
                    isSaving = false
                    
                    if let error = error {
                        errorMessage = error.localizedDescription
                        return
                    }
                    
                    onSaved()
                    dismiss()
                }
            }
    }
}

#Preview {
    ViewPostsView()
}
