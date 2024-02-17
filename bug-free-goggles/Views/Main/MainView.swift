////
//  MainView.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
  
    @StateObject private var routerPath = RouterPath()
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
     }
    var body: some View {
        TabView {
            Group {
                NavigationStack(path: $routerPath.path) {
                    HomeView()
                        .withAppRouter()
                        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                        .tabItem {
                            VStack{
                                Text("Home")
                                Image("houseIcon")
                            }
                        }
                }
                .environmentObject(routerPath)
                
                NavigationStack {
                    BookingView()
                        .withAppRouter()
                        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                        .tabItem {
                            VStack{
                                Text("Bookings")
                                Image("confirmIcon")}
                        }
                }
                .environmentObject(routerPath)
                NavigationStack {
                    HostingSelection()
                        .withAppRouter()
                        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                        .environmentObject(appState)
                        .tabItem {
                            VStack{
                                Text("Host")
                                Image(systemName:"plus.app.fill")}
                        }
                }
                .environmentObject(routerPath)
                NavigationStack {
                    InboxView()
                        .withAppRouter()
                        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                        .tabItem {
                            VStack{
                                Text("Inbox")
                                Image("notificationIcon")}
                        }
                }.environmentObject(routerPath)
                NavigationStack {
                    ProfileView(isMyProfile: true, roomMate: PreviewData.roomMateData)
                        .withAppRouter()
                        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                        .tabItem {
                            VStack{
                                Text("Profile")
                                Image("accountIcon")}
                        }
                }.environmentObject(routerPath)
            }
            .toolbarBackground(Color.white, for: .tabBar)
        }
       
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
       // @EnvironmentObject var appState: AppState
        NavigationStack{
            MainView()
                //.environmentObject(appState)
        }
    }
}
