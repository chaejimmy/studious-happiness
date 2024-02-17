////
//  ReviewPayload.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

extension ReviewData{
    struct AddPayload: Codable{
        let rating: Int
        let comment: String
    }
    
    struct UpdatePayload: Codable{
        let ratings: Int
        let comment: String
        let status: Int
    }
}
