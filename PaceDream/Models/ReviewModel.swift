//
//  ReviewModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 02/09/2023.
//

import Foundation

struct ReviewModel: Codable{
    let name: String
    let rating: Double
    let bookingNumber: String
    let userImage: String
    let views: Int
    let shares: Int
    let review: String
    let createdAt: Date
    
    var timeElapsed: String{
        let formatter = RelativeDateTimeFormatter ()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString (for: createdAt, relativeTo: Date())
    }
}
