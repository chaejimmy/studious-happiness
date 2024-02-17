////
//  ProfileViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 05/05/23.
//

import Foundation

enum ProfileTabs: Int, CaseIterable {
    
    static var otherUserProfileTabs: [ProfileTabs] = [
        .alreadyBooked, .lookingfForPartners, .reviews
    ]
    
    case alreadyBooked = 0
    case lookingfForPartners = 1
    case reviews = 2
    case wishlist = 3
    case draft = 4
    
    var title: String {
        switch self {
        case .alreadyBooked: return "Already Booked"
        case .lookingfForPartners: return "Looking for Partners"
        case .reviews: return "Reviews"
        case .wishlist: return "Wishlist"
        case .draft: return "draft"
        }
    }
}

class ProfileViewModel: ObservableObject {
    static let shared = ProfileViewModel()
    
    @Published var showMore: Bool = false
    @Published var selectedTab: ProfileTabs = .alreadyBooked
    @Published var selectedTabIndex: Int = 0
    @Published var openSettingView: Bool = false
    @Published var isLiked: Bool = false
}
