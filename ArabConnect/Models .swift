import Foundation

struct User: Identifiable {

    let id: String
    let fullName: String
    let email: String

}

struct Post: Identifiable {

    let id: String
    let title: String
    let description: String
    let category: String
    let createdBy: String
    let createdAt: Date

}
