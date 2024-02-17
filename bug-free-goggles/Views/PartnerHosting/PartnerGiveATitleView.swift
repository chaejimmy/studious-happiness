////
//  PartnerGiveATitleView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct PartnerGiveATitleView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: String.Hosting.giveATitlePageTitle,
            subtitle: String.Hosting.giveATitlePageSubTitle,
            isNextDisable: vm.giveATitleValidation,
            onNext: onNext
        ) {
            HeadingNoteView(heading: $vm.heading, note: $vm.note)
        }
        .navigationDestination(isPresented: $vm.navigateToPricingLimit) {
            PartnerPriceLimitView()
                .environmentObject(vm)
        }
    }
    
    func onNext() {
        vm.navigateToPricingLimit = true
    }
}

struct PartnerGiveATitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PartnerGiveATitleView()
                .environmentObject(PartnerHostingViewModel())
        }
    }
}
