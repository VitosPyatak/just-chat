//
//  UserProfile.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import Foundation

struct UserProfile: Identifiable, Codable, Equatable {
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        lhs.username == rhs.username && lhs.userId == rhs.userId && lhs.imageUrl == lhs.imageUrl
    }
    
    var id =  UUID().uuidString
    var username: String
    var imageUrl: String
    var userId: String

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case imageUrl
        case userId
    }
}
