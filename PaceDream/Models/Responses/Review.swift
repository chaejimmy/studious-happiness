////
//  Review.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

extension ReviewData{
    struct UpdateResponse: Codable{
        let review: ReviewData?
    }
    
    struct DeleteResponse: Codable{
        let message: String
        
        enum CodingKeys: String, CodingKey {
            case message = "msg"
        }
    }
}
