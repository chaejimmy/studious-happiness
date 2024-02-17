////
//  ProposalShareView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct ProposalShareView: View {
    @State var shareOption: RoomSharingOption? = .none
    @State var persons: Int = 1
    @State var bedrooms: Int = 1
    @State var beds: Int = 1
    @State var bathrooms: Int = 1
    @State private var toAmenitiesView: Bool = false
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: .Hosting.whoWillshareTheRoomTitle,
            subtitle: .Hosting.whoWillshareTheRoomSubTitle,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $toAmenitiesView) {
            ProposalAmenitiesView()
        }
    }
    
    var content: some View {
        VStack(spacing: 24) {
            HStack{
                RoomSharingSelectorView(option: $shareOption, spacing: 8)
            }
            .padding(.horizontal, -16)
            VStack(alignment: .leading, spacing: 12) {
                Text(String.Hosting.sharableDetails)
                    .style(.subheadline1)
                StepperRowView(
                    title: .Hosting.persons,
                    stepValue: $persons,
                    spacing: 0,
                    maxWidth: 60
                )
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(String.Hosting.sharableDetails)
                    .style(.subheadline1)
                VStack(spacing: 24) {
                    StepperRowView(
                        title: .Hosting.bedrooms,
                        stepValue: $bedrooms,
                        spacing: 0,
                        maxWidth: 60
                    )
                    
                    StepperRowView(
                        title: .Hosting.beds,
                        stepValue: $beds,
                        spacing: 0,
                        maxWidth: 60
                    )
                    StepperRowView(
                        title: .Hosting.bathrooms,
                        stepValue: $bathrooms,
                        spacing: 0,
                        maxWidth: 60
                    )
                }
            }
        }
    }
    
    func onNext() {
        toAmenitiesView = true
    }
}

struct ProposalShareView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProposalShareView()
        }
    }
}
