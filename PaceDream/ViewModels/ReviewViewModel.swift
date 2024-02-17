//
//  ReviewViewModel.swift
//  Totel (iOS)
//
//  Created by Don Bouncy on 02/09/2023.
//

import SwiftUI

class BusinessViewModel: ObservableObject{
    @Published var reviews: [ReviewModel] = [
        ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ReviewModel(name: "Mishell De Alwis", rating: 4.5, bookingNumber: "Booking No : OGF123546", userImage: "Oval", views: 452, shares: 98, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", createdAt: Date()),
    ]
}

enum BusinessTab: Int, CaseIterable{
    case earnings = 0
    case reviews
    
    var title: String{
        switch self {
        case .earnings: return "Earnings"
        case .reviews: return "Reviews"
        }
    }
}
