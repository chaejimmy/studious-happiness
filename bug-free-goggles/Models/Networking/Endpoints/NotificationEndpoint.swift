////
//  NotificationEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to notifications
enum NotificationEndpoint: String, EndpointProtocol {
    case addNotification = "user/add_notification"
    case getAllNotification = "user/get_all_notification"
    case getUserNotification = "user/get_user_notifications"
    case blockNotification = "user/block_notification"
    case sendNotification = "user/send-notification"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod {
        switch self {
        case .addNotification, .sendNotification:
            return .post
        case .getAllNotification, .getUserNotification:
            return .get
        case .blockNotification:
            return .put
        }
    }
}
