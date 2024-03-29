////
//  ProposalStayTypeView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct ProposalRoomDescriptionView: View {
    @State var basicSelection: Set<RoomDescription> = []
    @State var houseSelection: Set<RoomDescription> = []
    @State private var toPlaceView: Bool = false
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: .proposal.roomDescription.title,
            subtitle: .proposal.roomDescription.subtitle,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $toPlaceView) {
            ProposalPlaceView()
        }
    }
    
    var content: some View{
        VStack(alignment: .leading, spacing: 8) {
            RoomDescriptionSelectionView(
                descriptions: .basic,
                selection: $basicSelection
            )
            RoomDescriptionSelectionView(
                descriptions: .house,
                selection: $houseSelection
            )
        }
        .padding(.horizontal, -16)
    }
    
    func onNext() {
        toPlaceView = true
    }
}

struct ProposalRoomDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProposalRoomDescriptionView()
        }
    }
}
