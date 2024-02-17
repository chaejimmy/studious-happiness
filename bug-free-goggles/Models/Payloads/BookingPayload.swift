////
//  BookingPayload.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct BookingPayload: Codable {
    let userId: String
    let roomId: RoomData.ID
    let wishlistId: WishlistData.ID
    let checkInDate: String
    let checkOutDate: String
    let paymentAmount: Int
    let paymentMethod: String
    let paymentCurrency: String
    let paymentStatus: String
    
    init(userId: String, roomId: RoomData.ID, wishlistId: WishlistData.ID, checkInDate: Date, checkOutDate: Date, paymentAmount: Int, paymentMethod: String, paymentCurrency: String, paymentStatus: String) {
        self.userId = userId
        self.roomId = roomId
        self.wishlistId = wishlistId
        self.checkInDate = checkInDate.toString()
        self.checkOutDate = checkOutDate.toString()
        self.paymentAmount = paymentAmount
        self.paymentMethod = paymentMethod
        self.paymentCurrency = paymentCurrency
        self.paymentStatus = paymentStatus
    }
    
    init(userId: String, roomId: String, wishlistId: String, checkInDate: Date, checkOutDate: Date, payment: PaymentData) {
        self.userId = userId
        self.roomId = roomId
        self.wishlistId = wishlistId
        self.checkInDate = checkInDate.toString()
        self.checkOutDate = checkOutDate.toString()
        self.paymentAmount = payment.amount
        self.paymentMethod = payment.paymentMethod
        self.paymentCurrency = payment.currency
        self.paymentStatus = payment.paymentStatus
    }
}
