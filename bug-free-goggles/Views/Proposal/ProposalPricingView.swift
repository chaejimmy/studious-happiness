////
//  ProposalPricingView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct ProposalPricingView: View {
    @State var price: Int = 0
    @State private var toRoomDescriptionView: Bool = false
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: .proposal.pricing.title,
            subtitle: .proposal.pricing.subtitle,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $toRoomDescriptionView) {
            ProposalRoomDescriptionView()
        }
    }
    
    var content: some View{
        VStack(alignment: .leading, spacing: 12) {
            PricingPerDayStepperView(value: $price)
            Text("His Bid rate is $75 to $90")
                .font(.circular(size: 14))
                .foregroundColor(.lightGrayText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func onNext() {
        toRoomDescriptionView = true
    }
}

struct ProposalPricingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProposalPricingView()
        }
    }
}
