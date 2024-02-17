//
//  TabBarView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 12/05/2023.
//

import SwiftUI
struct TabBarView: View {
    var body: some View {
        TabView {
            // Add your tab views here
        }
        
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .background(Color.white) // Set the desired background color for the tab bar
    }
}
