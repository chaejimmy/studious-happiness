////
//  ProfileTab.swift
//  bug-free-goggles
//
//  Created by Mac on 28/07/2023.
//

import SwiftUI
struct ProfileTab: View {
    @StateObject private var routerPath = RouterPath()
    @Binding var popToRootTab: Tab
    //@EnvironmentObject var appState: AppState
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            ProfileView(isMyProfile: true, roomMate: PreviewData.roomMateData)
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                .navigationTitle("Profile")
                
        }
        .environmentObject(routerPath)
    }
}
