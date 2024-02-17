////
//  LocationData.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

public struct LocationData: Codable, Equatable ,Hashable{
    let type: String
    let name: String
    let coordinates: CoordinateData
    
}
