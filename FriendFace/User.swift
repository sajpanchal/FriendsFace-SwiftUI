//
//  User.swift
//  FriendFace
//
//  Created by saj panchal on 2021-08-01.
//

import Foundation
struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

class UserCodable: ObservableObject {
    @Published var users: [User] = []
    
}
