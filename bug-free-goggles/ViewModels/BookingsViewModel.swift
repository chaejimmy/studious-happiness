//
//  BookingsViewModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 31/08/2023.
//

import Foundation
import FSCalendar

class BookingsViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var bookings: [BookingModel] = [
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .complete),
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .ongoing),
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .complete),
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .complete),
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .ongoing),
        BookingModel(id: UUID(), name: "Jacky Shopy", price: 62.00, userImage: "booking-img", checkInDate: Date(), checkOutDate: Date.init(timeIntervalSinceNow: 74000), bookingDetails: "Jacky Shopy's Booking", bookingStatus: .complete),
    ]
}

enum BookingStatus: Codable{
    case complete
    case ongoing
}

enum BookingTab: Int, CaseIterable {
    case booked = 0 
    case history = 1
    case calender = 2
    
    var title: String {
        switch self {
        case .booked: return "Booked"
        case .history: return "History"
        case .calender: return "Calender"
        }
    }
}

enum CalendarType: CaseIterable {
    case week
    case month
    case annual
    
    var title: String {
        switch self {
        case .week: return "Week"
        case .month: return "Month"
        case .annual: return "Annual"
        }
    }
    
    var type: FSCalendarScope {
        switch self {
        case .week: return .week
        case .month: return .month
        case .annual: return .month 
        }
    }
}
