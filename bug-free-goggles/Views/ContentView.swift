//
//  ContentView.swift
//  bug-free-goggles
//
//  Created by mac on 01/05/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("hasOnboardingSeen") var hasOnboardingSeen = false
    @State private var selectedTab: Tab = .home
    @State private var popToRootTab: Tab = .other
    
    private var availableTabs: [Tab] {
        self.isLoggedIn ? appState.hostMode ? Tab.hostTabs()  : Tab.loggedInTabs() : Tab.loggedOutTab()
    }

    @StateObject private var appState = AppState.shared
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        if hasOnboardingSeen {
            
            tabBarView
                .environmentObject(appState)
            
            
            //HostingTabView()
        } else {
            OnboardingView()
        }
    }
    private var tabBarView: some View {
        TabView(selection: .init(get: {
            selectedTab
        }, set: { newTab in
            if newTab == selectedTab {
                /// Stupid hack to trigger onChange binding in tab views.
                popToRootTab = .other
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    popToRootTab = selectedTab
                }
            }
            selectedTab = newTab
        })) {
            
            ForEach(availableTabs) { tab in
                tab.makeContentView(popToRootTab: $popToRootTab)
                    .tabItem {
                        tab.label.labelStyle(IconOnlyLabelStyle())
                    }
                    .tag(tab)
                    .toolbarBackground(Color.white, for: .tabBar)
            }
            
            
        }
        .tint(.appPrimary)
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
