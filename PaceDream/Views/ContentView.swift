//
//  ContentView.swift
//  PaceDream
//
//  Created by Vipin Saini on 01-01-2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("hasOnboardingSeen") var hasOnboardingSeen = false
    @State private var selectedTab: Tab = .home
    @State private var popToRootTab: Tab = .profile
    
    @State private var tabViewKey = UUID() // Key to refresh TabView

    private var availableTabs: [Tab] {
        isLoggedIn ? (appState.hostMode ? Tab.hostTabs() : Tab.loggedInTabs()) : Tab.loggedOutTab()
    }

    @StateObject private var appState = AppState.shared

    var body: some View {
        if hasOnboardingSeen {
            TabView(selection: $selectedTab, content: {
                ForEach(availableTabs) { tab in
                    tab.makeContentView(popToRootTab: $popToRootTab)
                        .tabItem { tab.label.labelStyle(IconOnlyLabelStyle()) }
                        .tag(tab)
                }
            })
            .environmentObject(appState)
            .tint(.appPrimary)
            .id(tabViewKey) // Apply the key here
            .onChange(of: isLoggedIn) { _ in
                tabViewKey = UUID() // Change the key when isLoggedIn changes
            }
            .onChange(of: appState.hostMode) { _ in
                tabViewKey = UUID() // Also change the key when hostMode changes
            }
        } else {
            OnboardingView()
        }
    }
}



#Preview {
    ContentView()
}
