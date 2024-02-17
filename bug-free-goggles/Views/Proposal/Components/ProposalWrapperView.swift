////
//  ProposalWrapperView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct ProposalWrapperView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    var isNextDisable: Bool = false
    var isFooterVisible: Bool = true
    var onBack: (() -> Void)? = nil
    let onNext: () -> Void
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 80)
            if isFooterVisible{
                HStack {
                    BottomBackButtonView {
                        backAction()
                    }
                    Spacer()
                    
                    Button(action: onNext) {
                        Text(String.Hosting.next)
                    }
                    .buttonStyle(secondaryButtonStyle(isDisable: isNextDisable))
                    .disabled(isNextDisable)
                }
                .padding(16)
                .background(Color.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    backAction()
                }
            }
        }
    }
    
    func backAction(){
        if let onBack = onBack{
            onBack()
        }
        else {
            dismiss()
        }
    }
}

struct ProposalWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProposalWrapperView(onNext: {}) {
                Color.blue
            }
        }
        
        NavigationView {
            ProposalWrapperView(isFooterVisible: false, onNext: {}) {
                Color.blue
            }
        }
    }
}
