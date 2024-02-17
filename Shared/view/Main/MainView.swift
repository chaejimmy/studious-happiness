//
//  MainView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 12/05/2023.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().tintColor = UIColor(Color.appPrimary)
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("houseIcon")
                }
            Text("Booking")
                .tabItem {
                    Image("confirmIcon")
                }
            NotificationListView()
                .tabItem {
                    Image("notificationIcon")
                }
            ProfileView()
                .tabItem {
                    Image("accountIcon")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
