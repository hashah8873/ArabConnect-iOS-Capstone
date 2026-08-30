# ArabConnect

## 📱 Mobile Capstone Project

ArabConnect is an iOS mobile application designed to support Arabic-speaking newcomers and immigrants in Canada by providing easy access to community resources, government programs, employment opportunities, housing information, healthcare services, and settlement support.

---

# 🎯 Project Goals

- Help newcomers understand their rights and available services.
- Provide organized access to government programs.
- Connect users with community resources.
- Support Arabic-speaking communities across Canada.
- Build a simple, user-friendly mobile experience using SwiftUI and Firebase.

---

# ✨ Main Features

- Secure User Authentication
- User Registration
- User Login
- User Profile
- Edit User Profile
- Logout
- Government Programs
- Jobs Listings
- Housing Resources
- Healthcare Information
- Education Resources
- Newcomer Rights
- Community Posts
- Add Community Posts
- View Community Posts
- Search Community Posts
- Filter Posts by Category
- View Post Details
- Edit Community Posts
- Delete Community Posts
- Arabic & English Support (Planned)

---

# 📱 Application Screens

## Authentication

- Splash Screen
- Welcome Screen
- Login Screen
- Register Screen

## Main

- Home Screen
- Profile Screen
- Edit Profile Screen

## Community Posts

- Add Post Screen
- View Posts Screen
- Post Details Screen
- Edit Post Screen

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
- ✅ Built Edit Profile screen.
- ✅ Created Add Post screen.
- ✅ Created View Posts screen.
- ✅ Created Post Details screen.
- ✅ Created Edit Post functionality.
- ✅ Created Jobs screen.
- ✅ Created Housing screen.
- ✅ Created Healthcare screen.
- ✅ Created Education screen.
- ✅ Created Government Programs screen.
- ✅ Created Newcomer Rights screen.
- ✅ Implemented navigation between application screens.
- ✅ Improved Community Posts user interface.

---

# 🔐 Firebase Authentication

- ✅ Connected the application to Firebase.
- ✅ Configured GoogleService-Info.plist.
- ✅ Installed Firebase SDK packages.
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

## Completed

- ✅ Created Post model.
- ✅ Created PostService.
- ✅ Created PostViewModel.
- ✅ Built Add Post screen.
- ✅ Connected Add Post to Firestore.
- ✅ Created `posts` collection in Firestore.
- ✅ Successfully saved community posts to Firestore.
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

- ✅ Created User model.
- ✅ Created UserService.
- ✅ Created UserViewModel.
- ✅ Display user information from Firestore.
- ✅ Display user's full name.
- ✅ Display user's email address.
- ✅ Added Edit Profile screen.
- ✅ Connected profile updates to Firestore.
- ✅ Added Logout functionality.
- ✅ Connected profile management with Firebase Authentication.

---

# 🏗️ MVVM Architecture

The project is organized using the Model-View-ViewModel (MVVM) architecture to separate application data, business logic, and user interface components.

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

---

# 📊 Current Application Flow

### Authentication Flow

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
