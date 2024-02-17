////
//  SuccessMessage.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

struct SuccessMessage: Codable{
    let success: Bool
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case message = "msg"
    }
}
