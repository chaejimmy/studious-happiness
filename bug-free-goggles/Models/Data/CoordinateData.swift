////
//  CoordinateData.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

struct CoordinateData: Codable,Equatable, Hashable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "0"
        case longitude = "1"
    }
}
