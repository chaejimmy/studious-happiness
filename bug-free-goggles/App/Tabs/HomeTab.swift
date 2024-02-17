////
//  HomeTab.swift
//  bug-free-goggles
//
//  Created by Mac on 28/07/2023.
//

import SwiftUI


struct HomeTab: View {
    @StateObject private var routerPath = RouterPath()
    @Binding var popToRootTab: Tab
    init(popToRootTab: Binding<Tab>) {
      _popToRootTab = popToRootTab
    }
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            HomeView()
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                
        }
        .environmentObject(routerPath)
    }
}
