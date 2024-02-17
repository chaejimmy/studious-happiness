////
//  Hobbies.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

enum Hobbies: CaseIterable {
    case cooking
    case learningLanguages
    case art
    case music
    case gym
    case photography
    case travel
    case swimming
    case playingGames
    case sports
    case dance
    
    var title: String {
        switch self {
        case .cooking: return "Cooking"
        case .learningLanguages: return "Learning Languages"
        case .music: return "Music"
        case .gym: return "Gym"
        case .photography: return "Photography"
        case .travel: return "Travel"
        case .art: return "Art"
        case .swimming: return "Swimming"
        case .playingGames: return "Playing Games"
        case .sports: return "Sports"
        case .dance: return "Dance"
        }
    }
}
