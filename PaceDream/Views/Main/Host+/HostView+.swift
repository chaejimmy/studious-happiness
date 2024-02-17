////
//  HostView+.swift
//  bug-free-goggles
//
//  Created by Mac on 27/07/2023.
//

import SwiftUI

struct HostingSelection: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            
            Text("Here you can become the family")
                .font(.circular(size: 20,weight: .medium))
                .font(.headline)
                .padding(.leading, 8)
            
            
            SelectTotelAction(
                title: "Share your room",
                caption: "Please provide information about your home. People will find it appealing.",
                image: "homeimage") {
                    appState.shouldShowAdds.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        appState.shouldShowHostingView.toggle()
                    }
                }
            
            SelectTotelAction(
                title: "Find roommate",
                caption: "Please share your preferences, and we will help you find a suitable roommate.",
                image: "partnerimage") {
                    appState.shouldShowAdds.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.07){
                        appState.shouldShowPartnerHostingView.toggle()
                    }
                }
            
            
            Spacer()
            
        }
        
        .fullScreenCover(isPresented: $appState.shouldShowHostingView, content: {
            NavigationStack{
                HostAddressSelectionView()
            }
        })
        .fullScreenCover(isPresented: $appState.shouldShowPartnerHostingView, content: {
           NavigationStack{
                //PartnerAddressSelectionView()
               EnableLocationView()
            }
        })
        //        .navigationDestination(isPresented: $appState.shouldShowHostingView, destination: {
        //            NavigationStack{
        //                HostAddressSelectionView()
        //             }
        //        })
//                .navigationDestination(isPresented: $appState.shouldShowPartnerHostingView, destination: {
//                    NavigationStack{
//                        PartnerAddressSelectionView()
//                     }
//                })
//                .id(appState.id)
    }
    
}


struct HostingSelection_Previews: PreviewProvider {
    static var previews: some View {
        HostingSelection()
    }
}
