////
//  BookedType.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

enum BookedType: Int, CaseIterable {
    case hourlyRoom = 0
    case travelRoommate = 1
    case eventSpaces = 2
    case parking = 3
    case storage = 4
    case education = 5
    case business = 6
    case electricCharging = 7
    case petCare = 8
    case daytimeRoom = 9
    case personalFitness = 10
    case gamingArcades = 11
    case nighttimeRoom = 12
    
    var title: String {
        switch self {
        case .hourlyRoom: return "Hourly Room"
        case .travelRoommate: return "Travel Roommate"
        case .eventSpaces: return "Event Spaces"
        case .parking: return "Parking"
        case .storage: return "Storage"
        case .education: return "Education"
        case .business: return "Business"
        case .electricCharging: return "Electric Charging"
        case .petCare: return "Pet Care"
        case .daytimeRoom: return "Daytime Room"
        case .personalFitness: return "Personal Fitness"
        case .gamingArcades: return "Gaming Arcades"
        case .nighttimeRoom: return "Nighttime Room"
        }
    }
    
    var image: String {
        switch self {
        case .hourlyRoom: return "hourlyRoom"
        case .travelRoommate: return "travelRoomates"
        case .eventSpaces: return "eventSpace"
        case .parking: return "parking"
        case .storage: return "storage"
        case .education: return "education"
        case .business: return "business"
        case .electricCharging: return "charging"
        case .petCare: return "petCare"
        case .daytimeRoom: return "daytimeRoom"
        case .personalFitness: return "personalFitness"
        case .gamingArcades: return "gammingRoom"
        case .nighttimeRoom: return "nightTimeRoom"
        }
    }
}
