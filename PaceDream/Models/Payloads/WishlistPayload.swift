////
//  WishlistPayload.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

extension WishlistData{
    struct RoomUserPayload: Codable{
        let roomId: RoomData.ID
        let userId: String
        
        enum CodingKeys: String, CodingKey {
            case roomId = "room_id"
            case userId = "user_id"
        }
        
        init(roomId: RoomData.ID, userID: String) {
            self.roomId = roomId
            self.userId = userID
        }
    }
    
    struct UserPayload: Codable{
        let userId: String
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
        }
        
        init(userId: String) {
            self.userId = userId
        }
    }
}
