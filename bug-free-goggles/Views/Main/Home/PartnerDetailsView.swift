////
//  PartnerDetailsView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct PartnerDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    let roomMate: RoommateData
    let images: [String] = ["image2", "image3", "image4"]
    @State var shouldShowSendProposal = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 8) {
                CustomNavBar(title: roomMate.name, isVerified: true){
                    dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ImagePagerView(images: roomMate.imageList, dotSize: 6)
                        NameAddressView(
                            name: roomMate.name,
                            address: roomMate.address,
                            isVerified: true
                        )
                        
                        userDescriptionView
                            .padding(.top, 4)
                        
                        basicInfo
                            .padding(.top, 4)
                        
                        CompatibleNoteView()
                        
                        Spacer(minLength: 100)
                    }
                    .background(Color.darkWhite)
                }
                
            }
            ImageTextButton(label: "Send a Proposal", image: "proposalIcon", action: {
                appState.shouldShowSendProposal.toggle()
            })
                .padding()
                .background(Color.white)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $appState.shouldShowSendProposal) {
            NavigationStack{MessagesScreen()}
        }
//        .fullScreenCover(isPresented: $appState.shouldShowSendProposal, content: {
//            NavigationStack{
//                //ProposalSubmisionView()
//                MessagesScreen()
//            }
//              })
    }
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Basic Info")
                .font(.system(size: 17, weight: .semibold))
            GridArrangeView(list: PreviewData.basicInfo)
        }
        .padding(.top)
        .padding(.horizontal)
        .background(Color.white)
    }
    
    var userDescriptionView: some View {
        VStack(spacing: 16) {
            GridArrangeView(list: roomMate.roomMateDetails())
            NavigationLink(destination: ProfileView(roomMate: roomMate)) {
                Text("View Profile")
                    .font(.system(size: 17, weight: .semibold))
            }
            .buttonStyle(FixedPaddingButtonStyle(background: .black))

        }
        .padding()
        .background(Color.white)
    }
    
}

struct PartnerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PartnerDetailsView(roomMate: PreviewData.roomMateData)
        }
    }
}
