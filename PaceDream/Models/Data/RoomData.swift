////
//  RoomData.swift
//  bug-free-goggles
//
//  Created by Mac on 16/05/23.
//

import Foundation

public struct RoomData: Codable, Identifiable, Equatable, Hashable{
    public let id: String
    let roomNumber: Int
    let roomName: String
    let lookingPlaces: String
    let reserveFrom: Date?
    let reserveTo: Date?
    let roomType: String
    let roomDescription: String
    let roomStatus: String
    let roomPrice: Int
    let roomFeatures: [String]
    let images: [ImageData]
    let location: LocationData?
    
    var dateRange: String {
        let start = reserveFrom?.toString(format: .ddMMM) ?? ""
        let end = reserveTo?.toString(format: .ddMMM) ?? ""
        return "\(start) - \(end)"
    }
    
    var imageList: [String] {
        images.map { $0.url }
    }
    
    var roomDetailes: [KeyValueModel] {
        [
            KeyValueModel(key: "Rent", value: "$\(roomPrice)/night"),
            KeyValueModel(key: "Duration", value: dateRange),
            KeyValueModel(key: "Feature", value: roomFeatures.joined(separator: "\n"))
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case roomNumber
        case roomName
        case lookingPlaces
        case reserveFrom
        case reserveTo
        case roomType
        case roomDescription
        case roomStatus
        case roomPrice
        case roomFeatures
        case images
        case location
    }
    
    init(id: String, roomNumber: Int, roomName: String, lookingPlaces: String, reserveFrom: Date?, reserveTo: Date?, roomType: String, roomDescription: String, roomStatus: String, roomPrice: Int, roomFeatures: [String], images: [ImageData], location: LocationData?) {
        self.id = id
        self.roomNumber = roomNumber
        self.roomName = roomName
        self.lookingPlaces = lookingPlaces
        self.reserveFrom = reserveFrom
        self.reserveTo = reserveTo
        self.roomType = roomType
        self.roomDescription = roomDescription
        self.roomStatus = roomStatus
        self.roomPrice = roomPrice
        self.roomFeatures = roomFeatures
        self.images = images
        self.location = location
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.roomNumber = try container.decode(Int.self, forKey: .roomNumber)
        self.roomName = try container.decode(String.self, forKey: .roomName)
        self.lookingPlaces = try container.decode(String.self, forKey: .lookingPlaces)
        self.reserveFrom = try container.decodeDateIfPresent(forKey: .reserveFrom)
        self.reserveTo = try container.decodeDateIfPresent(forKey: .reserveTo)
        self.roomType = try container.decode(String.self, forKey: .roomType)
        self.roomDescription = try container.decode(String.self, forKey: .roomDescription)
        self.roomStatus = try container.decode(String.self, forKey: .roomStatus)
        self.roomPrice = try container.decode(Int.self, forKey: .roomPrice)
        self.roomFeatures = try container.decode([String].self, forKey: .roomFeatures)
        self.images = try container.decode([ImageData].self, forKey: .images)
        self.location = try container.decodeIfPresent(LocationData.self, forKey: .location)
    }
}



