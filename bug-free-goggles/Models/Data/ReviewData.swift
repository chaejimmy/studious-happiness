////
//  ReviewData.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

struct ReviewData: Codable, Identifiable {
    let id: String
    let user: String
    let room: String
    let images: [ImageData]
    let comment: String
    let rating: Int
    let status: Int
    let createdAt: Date
    let updatedAt: Date
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case room
        case images
        case comment
        case rating
        case status
        case createdAt
        case updatedAt
        case version = "__v"
    }
    
    init(id: String, user: String, room: String, images: [ImageData], comment: String, rating: Int, status: Int, createdAt: Date, updatedAt: Date, version: Int) {
        self.id = id
        self.user = user
        self.room = room
        self.images = images
        self.comment = comment
        self.rating = rating
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.version = version
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decode(String.self, forKey: .user)
        self.room = try container.decode(String.self, forKey: .room)
        self.images = try container.decode([ImageData].self, forKey: .images)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.status = try container.decode(Int.self, forKey: .status)
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.updatedAt = try container.decodeDate(forKey: .updatedAt)
        self.version = try container.decode(Int.self, forKey: .version)
    }
}
