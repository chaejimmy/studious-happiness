////
//  PartnerPriceLimitView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct PartnerPriceLimitView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: String.Constants.givePricingLimitTitle,
            subtitle: String.Constants.givePricingLimitSubTitle,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $vm.navigateToGiveAvailability) {
            PartnerAvailabilityView()
                .environmentObject(vm)
        }
    }
    
    var content: some View {
        GivePriceLimitView(isFromPartner: true){ picker, price, rateRange in
            
        }
    }
    
    func onNext() {
        vm.navigateToGiveAvailability = true
    }
}

struct PartnerPriceLimitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PartnerPriceLimitView()
                .environmentObject(PartnerHostingViewModel())
        }
    }
}
