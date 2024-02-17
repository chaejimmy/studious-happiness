////
//  NotificationItem.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import Foundation
import SwiftUI

enum NotificationType {
    case your_review
    case give_you_a_review
    case send_proposal
    
}

struct NotificationItem: Identifiable {
    var id: UUID = UUID()
    var type: NotificationType
    var profiles: [NotificationUserProfile]
    var createdAt: Date = Date()
}

struct NotificationUserProfile {
    var image: String
    var username: String
    var coverImage: String
}


let notifications: [NotificationItem] = [
    NotificationItem(type: .your_review, profiles: [users[0]], createdAt: Date()),
    NotificationItem(type: .send_proposal, profiles: [users[1], users[2]], createdAt: Date().addingTimeInterval(-5 * 60)),
    NotificationItem(type: .send_proposal, profiles: [users[0]], createdAt: Date().addingTimeInterval(-28 * 60)),
    NotificationItem(type: .give_you_a_review, profiles: [users[3]], createdAt: Date().addingTimeInterval(-5 * 60 * 60)),
    NotificationItem(type: .give_you_a_review, profiles: [users[4]], createdAt: Date().addingTimeInterval(-2 * 24 * 60 * 60)),
    NotificationItem(type: .your_review, profiles: [users[0]], createdAt: Date().addingTimeInterval(-8 * 24 * 60 * 60)),
    NotificationItem(type: .send_proposal, profiles: [users[1], users[2]], createdAt: Date().addingTimeInterval(-2 * 4 * 7 * 24 * 60 * 60)),
]

let users: [NotificationUserProfile] = [
    NotificationUserProfile(image: "stellaProfile", username: "stella_sf", coverImage: "image1"),
    NotificationUserProfile(image: "sugeevanProfile", username: "sugeevan_svg", coverImage: "image2"),
    NotificationUserProfile(image: "jamestalanProfile", username: "jamestalan", coverImage: "image2"),
    NotificationUserProfile(image: "mariaProfile", username: "maria_2", coverImage: "image3"),
    NotificationUserProfile(image: "starelliProfile", username: "starelli_kw", coverImage: "image4"),
]

func categorizeDates(_ items: [NotificationItem]) -> [String: [NotificationItem]] {
    let calendar = Calendar.current
    
    let groupedDates = Dictionary(grouping: items) { item in
        if calendar.isDateInToday(item.createdAt) {
            return "Today"
        } else if calendar.isDate(item.createdAt, equalTo: Date(), toGranularity: .weekOfYear) {
            return "This Week"
        } else if calendar.isDate(item.createdAt, equalTo: Date(), toGranularity: .month) {
            return "This Month"
        } else {
            return "Earlier"
        }
    }
    
    return groupedDates
}
