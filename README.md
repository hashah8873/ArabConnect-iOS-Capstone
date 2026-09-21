# ArabConnect

## 📱 Mobile Capstone Project

**ArabConnect** is an iOS mobile application designed to support Arabic-speaking newcomers and immigrants in Canada by providing easy access to community resources, government programs, employment opportunities, housing information, healthcare services, education resources, newcomer rights information, and settlement support.

The application was developed as a Mobile Capstone Project using **SwiftUI, Swift, Firebase Authentication, Cloud Firestore, Xcode, Git, and GitHub**.

---

# 🎯 Project Goals

- Help newcomers understand their rights and available services.
- Provide organized access to government programs.
- Connect users with community resources.
- Provide employment, housing, healthcare, and education resources.
- Support Arabic-speaking communities across Canada.
- Provide a simple and user-friendly mobile experience.
- Demonstrate the use of SwiftUI, Firebase, Firestore, and MVVM architecture.

---

# ✨ Main Features

- ✅ Secure User Authentication
- ✅ User Registration
- ✅ User Login
- ✅ User Profile
- ✅ Edit User Profile
- ✅ Logout
- ✅ Government Programs
- ✅ Jobs Listings
- ✅ Housing Resources
- ✅ Healthcare Information
- ✅ Education Resources
- ✅ Newcomer Rights
- ✅ Community Posts
- ✅ Add Community Posts
- ✅ View Community Posts
- ✅ Search Community Posts
- ✅ Filter Posts by Category
- ✅ View Post Details
- ✅ Edit Community Posts
- ✅ Delete Community Posts
- ✅ Post Ownership Management
- ✅ Firebase Authentication
- ✅ Cloud Firestore Integration
- ✅ MVVM Architecture

---

# 📱 Application Screens

## Authentication

- Splash Screen
- Welcome Screen
- Login Screen
- Register Screen

## Main Application

- Home Screen
- Profile Screen
- Edit Profile Screen

## Community Posts

- Add Post Screen
- View Posts Screen
- Post Details
- Edit Post
- Delete Post

## Community Resources

- Jobs
- Housing
- Healthcare
- Education
- Government Programs
- Newcomer Rights

---

# ✅ Current Progress

## User Interface

- ✅ Created complete SwiftUI project structure.
- ✅ Designed and implemented Splash Screen.
- ✅ Built Welcome Screen.
- ✅ Built Login Screen.
- ✅ Built Register Screen.
- ✅ Built Home Screen.
- ✅ Built Profile Screen.
- ✅ Built Edit Profile Screen.
- ✅ Created Add Post Screen.
- ✅ Created View Posts Screen.
- ✅ Created Post Details functionality.
- ✅ Created Edit Post functionality.
- ✅ Created Delete Post functionality.
- ✅ Created Jobs Screen.
- ✅ Created Housing Screen.
- ✅ Created Healthcare Screen.
- ✅ Created Education Screen.
- ✅ Created Government Programs Screen.
- ✅ Created Newcomer Rights Screen.
- ✅ Implemented navigation between application screens.
- ✅ Implemented Community Posts user interface.
- ✅ Implemented search and category filtering.

---

# 🔐 Firebase Authentication

- ✅ Connected the application to Firebase.
- ✅ Configured `GoogleService-Info.plist`.
- ✅ Integrated Firebase SDK.
- ✅ Implemented Firebase Authentication.
- ✅ Implemented user registration.
- ✅ Implemented user login.
- ✅ Implemented user logout.
- ✅ Maintained authenticated user sessions.
- ✅ Connected authenticated users with their Firestore profile data.

---

# ☁️ Cloud Firestore

- ✅ Connected Cloud Firestore.
- ✅ Created Firestore database.
- ✅ Created `users` collection.
- ✅ Created `posts` collection.
- ✅ Automatically store user information after registration.
- ✅ Retrieve user profile information from Firestore.
- ✅ Update user profile information.
- ✅ Save community posts to Firestore.
- ✅ Load community posts from Firestore.
- ✅ Update community posts.
- ✅ Delete community posts.
- ✅ Configured Firestore security rules for authenticated users.

### User Data Stored

- User ID
- Full Name
- Email Address
- Account Creation Date

### Post Data Stored

- Post ID
- Title
- Description
- Category
- Created By
- Created Date

---

# 👥 Community Posts

## Completed Features

- ✅ Created Post Model.
- ✅ Created PostService.
- ✅ Created PostViewModel.
- ✅ Built Add Post Screen.
- ✅ Connected Add Post to Firestore.
- ✅ Created `posts` collection in Firestore.
- ✅ Saved community posts to Firestore.
- ✅ Loaded posts from Firestore.
- ✅ Displayed community posts inside the application.
- ✅ Added Community Posts navigation to HomeView.
- ✅ Added Post Details functionality.
- ✅ Added Edit Post functionality.
- ✅ Added Delete Post functionality.
- ✅ Added post ownership handling.
- ✅ Added post creation date.
- ✅ Added category information to posts.

---

# 🔎 Search and Filtering

- ✅ Added search functionality to Community Posts.
- ✅ Users can search posts by title.
- ✅ Users can search posts by description.
- ✅ Users can search posts by category.
- ✅ Added "No Results" state.
- ✅ Added Clear Search functionality.
- ✅ Added category-based filtering.
- ✅ Improved post browsing and navigation.

---

# 👤 User Profile

- ✅ Created User Model.
- ✅ Created UserService.
- ✅ Created UserViewModel.
- ✅ Displayed user information from Firestore.
- ✅ Displayed user's full name.
- ✅ Displayed user's email address.
- ✅ Added Edit Profile Screen.
- ✅ Connected profile updates to Firestore.
- ✅ Added Logout functionality.
- ✅ Connected profile management with Firebase Authentication.

---

# 🏗️ MVVM Architecture

The project is organized using the **Model-View-ViewModel (MVVM)** architecture to separate application data, business logic, and user interface components.

### Models

- ✅ User Model
- ✅ Post Model

### Services

- ✅ UserService
- ✅ PostService

### ViewModels

- ✅ UserViewModel
- ✅ PostViewModel

### Views

- ✅ Authentication Views
- ✅ HomeView
- ✅ ProfileView
- ✅ EditProfileView
- ✅ AddPostView
- ✅ ViewPostsView
- ✅ Post Details View
- ✅ Edit Post View
- ✅ Community Resource Views

---

# 🔒 Firestore Security

- ✅ Configured Firestore security rules.
- ✅ Restricted user data access to authenticated users.
- ✅ Connected Firestore access with Firebase Authentication.
- ✅ Used authenticated user IDs to identify users and posts.
- ✅ Implemented ownership checks for community posts.

---

# 🔄 Application Flow

## Authentication Flow

```text
Splash Screen
      ↓
Welcome Screen
      ↓
Login / Register
      ↓
Firebase Authentication
      ↓
Home Screen
