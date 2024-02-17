//
//  HomeViewModel.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedBookedType: BookedType = .alreadyBooked
    @Published var openFilterSheet: Bool = false
    
}

enum BookedType: CaseIterable {
    case alreadyBooked
    case lookingForPartner
    case rentedRoom
    
    var title: String {
        switch self {
        case .alreadyBooked: return "Already Booked"
        case .lookingForPartner: return "Looking for Partner"
        case .rentedRoom: return "Rented Rooms"
        }
    }
}
