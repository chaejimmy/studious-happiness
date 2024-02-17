//
//  BookingsModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 01/09/2023.
//

import Foundation

struct BookingModel: Codable, Identifiable {
    let id: UUID
    let name: String
    let price: Double
    let userImage: String
    let checkInDate: Date
    let checkOutDate: Date
    let bookingDetails: String
    let bookingStatus: BookingStatus
}
