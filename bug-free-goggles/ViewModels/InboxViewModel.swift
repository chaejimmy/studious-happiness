//
//  InboxViewModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 01/09/2023.
//

import Foundation

class InboxViewModel: ObservableObject{
    @Published var notifications: [NotificationsModel] = [
        NotificationsModel(createdAt: Date(), username: ["stella_sf"], notificationImage: "Rectangle", userProfileImage: ["Oval"], notificationType: .review, notificationUsers: .single),
        
        NotificationsModel(createdAt: Date(), username: ["sugeevan_svg", "jamestalan"], notificationImage: "Rectangle (2)", userProfileImage: ["Oval","Oval2"], notificationType: .proposal, notificationUsers: .multiple),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-160000), username: ["stella_sf"], notificationImage: "Rectangle", userProfileImage: ["Oval"], notificationType: .review, notificationUsers: .single),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-160000), username: ["sugeevan_svg", "jamestalan"], notificationImage: "Rectangle (2)", userProfileImage: ["Oval","Oval2"], notificationType: .proposal, notificationUsers: .multiple),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-800000), username: ["stella_sf"], notificationImage: "Rectangle", userProfileImage: ["Oval"], notificationType: .proposal, notificationUsers: .single),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-800000), username: ["sugeevan_svg", "jamestalan"], notificationImage: "Rectangle (2)", userProfileImage: ["Oval","Oval2"], notificationType: .review, notificationUsers: .multiple),
        
        NotificationsModel(createdAt: Date(), username: ["stella_sf"], notificationImage: "Rectangle", userProfileImage: ["Oval"], notificationType: .review, notificationUsers: .single),
        
        NotificationsModel(createdAt: Date(), username: ["sugeevan_svg", "jamestalan"], notificationImage: "Rectangle (2)", userProfileImage: ["Oval","Oval2"], notificationType: .proposal, notificationUsers: .multiple),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-86400000), username: ["stella_sf"], notificationImage: "Rectangle", userProfileImage: ["Oval"], notificationType: .proposal, notificationUsers: .single),
        
        NotificationsModel(createdAt: Date().addingTimeInterval(-172800000), username: ["sugeevan_svg", "jamestalan"], notificationImage: "Rectangle (2)", userProfileImage: ["Oval","Oval2"], notificationType: .review, notificationUsers: .multiple),
        
    ]
    
    @Published var users: [ChatUserModel] = [
        ChatUserModel(first_name: "Stella", last_name: "Marium", profilePic: "Oval", email: "test@test.com"),
        ChatUserModel(first_name: "Jacky", last_name: "Shopy", profilePic: "Oval3", email: "test@test.com"),
        ChatUserModel(first_name: "Alexander", last_name: "Alex", profilePic: nil, email: "test@test.com"),
    ]
    
    @Published var chats: [ChatsModel] = []
    @Published var chatMessages: [ChatMessages] = []
    
    init() {
        let stellaMessages = [
            ChatMessages(chat: "Stella Marium", sender: "sender", message: "Hi,", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "sender", message: "Thanks for your help! Can you please describe your review??", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "me", message: "Hi👋", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "me", message: "It's fine, I'll do it. Thanks!", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "me", message: "What about this room?", chatMedia: ["msg1" ,"msg2", "", "msg3"], createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "sender", message: "Thank you so much!!", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "sender", message: "Keep in touch with me", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Stella Marium", sender: "sender", message: "Where are you now? I am waiting for your room key", chatMedia: nil, createdAt: Date()),
        ]
        
        let jackMessages = [
            ChatMessages(chat: "Jacky Shopy", sender: "sender", message: "Hi,", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "sender", message: "Thanks for your help! Can you please describe your review??", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "me", message: "Hi👋", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "me", message: "It's fine, I'll do it. Thanks!", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "me", message: "What about this room?", chatMedia: ["msg1" ,"msg2", "", "msg3"], createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "sender", message: "Thank you so much!!", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "sender", message: "Keep in touch with me", chatMedia: nil, createdAt: Date()),
            ChatMessages(chat: "Jacky Shopy", sender: "sender", message: "Where are you now? I am waiting for your room key", chatMedia: nil, createdAt: Date()),
        ]
        
        self.chatMessages.append(contentsOf: stellaMessages)
        self.chatMessages.append(contentsOf: jackMessages)

        self.chats = [
            ChatsModel(isGroupChat: false, name: "Stella Marium", users: [users[0], users[2]], unreadCount: 2, messages: chatMessages.filter{$0.chat == "Stella Marium"}, createdAt: Date(), updatedAt: Date()),
            ChatsModel(isGroupChat: false, name: "Jacky Shopy", users: [users[1], users[2]], unreadCount: nil, messages: chatMessages.filter{$0.chat == "Jacky Shopy"}, createdAt: Date(), updatedAt: Date()),
            ChatsModel(isGroupChat: false, name: "Stella Marium", users: [users[0], users[2]], unreadCount: 2, messages: chatMessages.filter{$0.chat == "Stella Marium"}, createdAt: Date(), updatedAt: Date()),
            ChatsModel(isGroupChat: false, name: "Jacky Shopy", users: [users[1], users[2]], unreadCount: nil, messages: chatMessages.filter{$0.chat == "Jacky Shopy"}, createdAt: Date(), updatedAt: Date()),
            ChatsModel(isGroupChat: false, name: "Stella Marium", users: [users[0], users[2]], unreadCount: 2, messages: chatMessages.filter{$0.chat == "Stella Marium"}, createdAt: Date(), updatedAt: Date()),
        ]
    }
    
    var todayNotifications: [NotificationsModel]{
        notifications.filter { notification in
            Calendar.current.isDateInToday(notification.createdAt)
        }
    }
    
    var weekNotifications: [NotificationsModel]{
        notifications.filter { notification in
            let isThisWeek = Calendar.current.isDate(notification.createdAt, equalTo: Date(), toGranularity: .weekOfYear)
            let isToday = Calendar.current.isDateInToday(notification.createdAt)
            
            return isThisWeek && !isToday
        }
    }
    
    var monthNotifications: [NotificationsModel]{
        notifications.filter { notification in
            let isThisMonth = Calendar.current.isDate(notification.createdAt, equalTo: Date(), toGranularity: .month)
            let isThisWeek = Calendar.current.isDate(notification.createdAt, equalTo: Date(), toGranularity: .weekOfYear)
            let dayResults = Calendar.current.compare(notification.createdAt, to: Date(), toGranularity: .day)
            
            var isToday = false
            
            switch dayResults{
            case .orderedSame: isToday = true
            default: isToday = false
            }
            
            return isThisMonth && !isThisWeek && !isToday
        }
    }
    
    var earlierNotifications: [NotificationsModel]{
        notifications.filter { notification in
            !Calendar.current.isDate(notification.createdAt, equalTo: Date(), toGranularity: .month) && !Calendar.current.isDate(notification.createdAt, equalTo: Date(), toGranularity: .weekOfYear)
        }
    }
    
    func createCustomDate(for date: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: date)!
    }
}

enum NotificationUsers: Codable{
    case single
    case multiple
}

enum HostNotificationType: Codable{
    case proposal
    case review
}

enum HostInboxTab: Int, CaseIterable{
    case messages = 0
    case notifications
    
    var title: String {
        switch self {
        case .messages: return "Messages"
        case .notifications: return "Notifications"
        }
    }

}
