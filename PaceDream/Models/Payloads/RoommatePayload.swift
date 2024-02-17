////
//  RoommatePayload.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct RoommatePayload: Codable{
    let roomId: RoomData.ID
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case userID = "user_id"
    }
    
    init(roomId: RoomData.ID, userID: String) {
        self.roomId = roomId
        self.userID = userID
    }
}

