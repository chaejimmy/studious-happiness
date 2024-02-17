//
//  ListingsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct ListingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var spaceVM: SpaceViewModel
    @State private var selection = 0
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(spaceVM.listings){ listing in
                        ListingsCard(listing: listing)
                    }
                }
            }
    }
}
