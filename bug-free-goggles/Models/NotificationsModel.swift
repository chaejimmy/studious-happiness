//
//  NotificationsModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 01/09/2023.
//

import Foundation

struct NotificationsModel: Codable{
    let createdAt: Date
    let username: [String]
    let notificationImage: String?
    let userProfileImage: [String]
    let notificationType: HostNotificationType
    let notificationUsers: NotificationUsers
    
    var timeElapsed: String{
        let formatter = RelativeDateTimeFormatter ()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString (for: createdAt, relativeTo: Date())
    }
}
