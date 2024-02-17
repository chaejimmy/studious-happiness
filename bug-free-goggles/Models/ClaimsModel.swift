//
//  ClaimsModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import Foundation

struct ClaimsModel: Codable, Identifiable{
    var id = UUID()
    let claimImage: String
    let claimName: String
    let claimDescription: String
    let price: Double
}
