////
//  SearchType.swift
//  bug-free-goggles
//
//  Created by Mac on 9/3/23.
//

import Foundation

enum SearchType: Int, CaseIterable {
    case stay = 0
    case hourly = 1
    case findRoommate = 2
//    case experiences = 1
//    case cars = 2
//    case flights = 3
    
    var title: String {
        switch self {
        case .stay: return "Stay"
        case .hourly: return "Hourly"
        case .findRoommate: return "Find Roommate"
//        case .experiences: return "Experiences"
//        case .cars: return "Cars"
//        case .flights: return "Flights"
        }
    }
}
