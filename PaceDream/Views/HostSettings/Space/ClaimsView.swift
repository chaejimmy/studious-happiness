//
//  ClaimsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct ClaimsView: View {
    @ObservedObject var spaceVM: SpaceViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(spaceVM.claims){ claim in
                    ClaimsCard(claim: claim)
                }
            }
        }

    }
}
