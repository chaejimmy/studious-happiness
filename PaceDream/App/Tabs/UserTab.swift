////
//  UserTab.swift
//  bug-free-goggles
//
//  Created by Mac on 9/18/23.
//

import SwiftUI

struct UserTab: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @StateObject private var routerPath = RouterPath()
    @Binding var popToRootTab: Tab
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            ZStack{
                if isLoggedIn {
                    HostSettingView()
                } else {
                    NotLoggedInView()
                        .navigationBarTitle("", displayMode: .inline)
                }
            }.withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                .navigationTitle("Profile")
        }
        .environmentObject(routerPath)
    }
}

