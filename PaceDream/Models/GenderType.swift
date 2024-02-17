////
//  GenderType.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

enum GenderType: CaseIterable {
    case male, female, preferNotToSay
    
    var title: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .preferNotToSay: return "Prefer not to say"
        }
    }
    
    var pronouns: String {
        switch self {
        case .male: return "He/Him"
        case .female: return "She/Her"
        case .preferNotToSay: return "Prefer not to say"
        }
    }
    
    var canStay: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .preferNotToSay: return "Both can Stay"
        }
    }
}
