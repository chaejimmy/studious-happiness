////
//  HostingTabView.swift
//  bug-free-goggles
//
//  Created by Mac on 26/07/2023.
//

import SwiftUI

struct HostingTabView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var locationManager = LocationManager()
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
     }
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        VStack{
                            Text("Bookings")
                            Image(systemName: "bookmark")
                        }
                    }
                
                BookingView()
                    .tabItem {
                        VStack{
                            Text("Inbox")
                            Image(systemName:"message")}
                    }
                
                HostingSelection()
                    .environmentObject(appState)
                    .tabItem {
                        VStack{
                            Text("Hotel")
                            Image(systemName:"building.2")}
                    }
               
                    InboxView()
                        .tabItem {
                            VStack{
                                Text("Business")
                                Image(systemName:"chart.pie")}
                        }
                
                
                More_ProfileView()
                    .tabItem {
                        VStack{
                            Text("More")
                            Image(systemName:"ellipsis")}
                    }
            }
            .toolbarBackground(Color.white, for: .tabBar)
        }
       .tint(.appPrimary)
       
       
    }
}

struct HostingTabView_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabView()
    }
}
