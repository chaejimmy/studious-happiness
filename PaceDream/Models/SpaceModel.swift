//
//  SpaceModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import Foundation

struct ListingsModel: Codable, Identifiable{
    var id = UUID()
    let listingImage: String
    let listingName: String
    let availableRooms: Int
    let rating: Double
    let price: Double
}
