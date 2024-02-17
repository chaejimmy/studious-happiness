////
//  ProposalHeadingView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct ProposalHeadingView: View {
    @EnvironmentObject var appState: AppState
    @State var heading = ""
    @State var note = ""
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: String.Hosting.giveATitlePageTitle,
            subtitle: String.Hosting.giveATitlePageSubTitle,
            isNextDisable: false,
            onNext: onNext
        ) {
            HeadingNoteView(heading: $heading, note: $note)
        }
    }
    
    func onNext() {
        appState.shouldShowSendProposal.toggle()
    }
}

struct ProposalHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        ProposalHeadingView()
    }
}
