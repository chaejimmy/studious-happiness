////
//  PartnerAvailabilityView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct PartnerAvailabilityView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    @EnvironmentObject var appState: AppState
    var body: some View {
       ProposalWrapperWithHeaderView(
        title: .proposal.availibility.title,
        subtitle: .proposal.availibility.subtitle,
        onNext: onNext) {
            GiveAvailabilityView()
        }
    }
    
    func onNext() {
         //appState.id = UUID()
         appState.shouldShowPartnerHostingView = false
    }
}

struct PartnerAvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerAvailabilityView()
            .environmentObject(PartnerHostingViewModel())
    }
}
