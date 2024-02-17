////
//  BookingData.swift
//  bug-free-goggles
//
//  Created by Mac on 16/05/23.
//

import Foundation

public struct BookingData: Codable, Identifiable,Equatable,Hashable {
    public let id: String
    let user: String
    let room: String
    let wishlist: String
    let checkInDate: Date
    let checkOutDate: Date
    let status: String
    let createdAt: Date
    let payment: PaymentData
    
    var roomData: RoomData?
    var roomMateData: RoommateData?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case room
        case wishlist
        case checkInDate
        case checkOutDate
        case status
        case createdAt
        case payment
        case roomData
        case roomMateData
    }
    
    init(id: String, user: String, room: String, wishlist: String, checkInDate: Date, checkOutDate: Date, status: String, createdAt: Date, payment: PaymentData, roomData: RoomData? = nil, roomMateData: RoommateData? = nil) {
        self.id = id
        self.user = user
        self.room = room
        self.wishlist = wishlist
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.status = status
        self.createdAt = createdAt
        self.payment = payment
        self.roomData = roomData
        self.roomMateData = roomMateData
    }
    
    init(id: String, user: String, room: String, wishlist: String, checkInDate: String, checkOutDate: String, status: String, createdAt: String, payment: PaymentData, roomData: RoomData? = nil, roomMateData: RoommateData? = nil) {
        self.id = id
        self.user = user
        self.room = room
        self.wishlist = wishlist
        self.checkInDate = Date.fromString(checkInDate) ?? Date()
        self.checkOutDate = Date.fromString(checkOutDate) ?? Date()
        self.status = status
        self.createdAt = Date.fromString(createdAt) ?? Date()
        self.payment = payment
        self.roomData = roomData
        self.roomMateData = roomMateData
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decode(String.self, forKey: .user)
        self.room = try container.decode(String.self, forKey: .room)
        self.wishlist = try container.decode(String.self, forKey: .wishlist)
        self.checkInDate = try container.decodeDate(forKey: .checkInDate)
        self.checkOutDate = try container.decodeDate(forKey: .checkOutDate)
        self.status = try container.decode(String.self, forKey: .status)
        self.createdAt = try container.decodeDate(forKey: .createdAt)
        self.payment = try container.decode(PaymentData.self, forKey: .payment)
        self.roomData = nil
        self.roomMateData = nil
    }
}

