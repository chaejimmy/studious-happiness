////
//  BookingEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to bookings
enum BookingEndpoint: String, EndpointProtocol {
    case getAllBookings = "user/get_all_bookings"
    case getUserBooking = "user/get_user_bookings"
    case addBooking = "user/add_booking"
    case updateBooking = "user/update_booking"
    case deleteBooking = "user/delete_booking"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        case .getAllBookings, .getUserBooking:
            return .get
        case .addBooking:
            return .post
        case .updateBooking:
            return .put
        case .deleteBooking:
            return .delete
        }
    }
}
