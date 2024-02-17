////
//  PetsSelectionType.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import Foundation

enum PetsSelectionType: CaseIterable {
    case pets_allowed
    case no_pets
    
    var title: String {
        switch self {
        case .pets_allowed: return "Pets-Allowed"
        case .no_pets: return "No-Pets"
        }
    }
    
    var image: String {
        switch self {
        case .pets_allowed: return "petsAllowedIcon"
        case .no_pets: return "noPetsIcon"
        }
    }
}
