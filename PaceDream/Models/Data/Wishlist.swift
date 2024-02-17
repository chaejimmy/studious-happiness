////
//  Wishlist.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct WishlistData: Codable, Identifiable {
    let id: String
    let user: String
    let wishlist: [WishlistItem]
    let createdAt: Date
    let updatedAt: Date
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case wishlist
        case createdAt
        case updatedAt
        case version = "__v"
    }
    
    init(id: String, user: String, wishlist: [WishlistItem], createdAt: Date, updatedAt: Date, version: Int) {
        self.id = id
        self.user = user
        self.wishlist = wishlist
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.version = version
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decode(String.self, forKey: .user)
        self.wishlist = try container.decodeIfPresent([WishlistItem].self, forKey: .wishlist) ?? []
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.updatedAt = try container.decodeDate(forKey: .updatedAt)
        self.version = try container.decode(Int.self, forKey: .version)
    }
}
