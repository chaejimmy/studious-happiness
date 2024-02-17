//
//  ChatsModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import Foundation

struct ChatsModel: Codable, Identifiable{
    var id = UUID()
    let isGroupChat: Bool
    let name: String
    let users: [ChatUserModel]
    let unreadCount: Int?
    let messages: [ChatMessages]
    let createdAt: Date
    let updatedAt: Date
}

struct ChatUserModel: Codable, Identifiable{
    var id = UUID()
    let first_name: String
    let last_name: String
    let profilePic: String?
    let email: String
}

struct ChatMessages: Codable, Identifiable{
    var id = UUID()
    let chat: String
    let sender: String?
    let message: String
    let chatMedia: [String]?
    let createdAt: Date
}
