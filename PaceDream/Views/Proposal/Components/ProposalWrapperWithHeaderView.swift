////
//  ProposalWrapperWithHeaderView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct ProposalWrapperWithHeaderView<Content: View>: View {
    let title: String
    let subtitle: String
    var isNextDisable: Bool = false
    var onBack: (() -> Void)? = nil
    let onNext: () -> Void
    @ViewBuilder let content: Content
    var body: some View {
        ProposalWrapperView(isNextDisable: isNextDisable, onBack: onBack, onNext: onNext) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HeaderView(
                        title: title,
                        subTitle: subtitle
                    )
                    content
                }
                .padding([.top, .horizontal], 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity,
                       alignment: .topLeading)
            }
        }
    }
}

struct ProposalWrapperWithHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProposalWrapperWithHeaderView(
                title: String.Hosting.giveYourAvailabilityPageTitle,
                subtitle: String.Hosting.giveYourAvailabilityPageSubTitle,
                onNext: {}
            ) {
                Color.blue
            }
        }
        
    }
}
