////
//  Tabs.swift
//  bug-free-goggles
//
//  Created by Mac on 28/07/2023.
//


import SwiftUI

enum Tab: Int, Identifiable, Hashable {
    case home,bookings, host, inbox, profile
    
    var id: Int {
        rawValue
    }
    
    static func loggedOutTab() -> [Tab] {
        [.home, .profile]
    }
    
    static func loggedInTabs() -> [Tab] {
            return [.home, .bookings, .inbox, .profile] 
    }
    
    
    static func hostTabs() -> [Tab] {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return [.home, .bookings, .host, .inbox, .profile]
        } else {
            return [.home, .bookings, .host, .inbox, .profile]
        }
    }
    
    @ViewBuilder
    func makeContentView(popToRootTab: Binding<Tab>) -> some View {
        switch self {
        case .home:
            HomeTab(popToRootTab: popToRootTab)
        case .bookings:
            BookingsTab(popToRootTab: popToRootTab)
        case .host:
            HostTab(popToRootTab: popToRootTab)
        case .inbox:
            InboxTab(popToRootTab: popToRootTab)
        case .profile:
            UserTab(popToRootTab: popToRootTab)
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            VStack{
                Text("Home")
                Image(iconName)
            }
        case .bookings:
            VStack{
                Text("Bookings")
                Image(iconName)
            }
        case .host:
            VStack {
                Text("Host")
                Image(systemName: iconName)
            }
        case .inbox:
            VStack{
                Text("Inbox")
                Image("notificationIcon")}
        case .profile:
            VStack{
                Text("Profile")
                Image("accountIcon")} 
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "houseIcon"
        case .bookings:
            return "confirmIcon"
        case .host:
            return "plus.app.fill"
        case .inbox:
            return "notificationIcon"
        case .profile:
            return "accountIcon"
        }
    }
}
