////
//  ImageData.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

struct ImageData: Codable, Identifiable,Equatable,Hashable {
    let id: String
    let url: String
    let publicId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url
        case publicId = "public_id"
    }
}
