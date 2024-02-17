////
//  AboutInterestView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct AboutInterestView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: String.Constants.tellAboutInterests,
            subtitle: String.Constants.placeSelectionSubTitle,
            isNextDisable: vm.aboutInterestsValidation,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $vm.navigateToUploadImages) {
            PartnerImageUploadView()
                .environmentObject(vm)
        }
    }
    
    var content: some View {
        HobbiesGridView(selectedHobbies: $vm.selectedHobbies, chipBGColor: .appPrimary)
    }
    
    func onNext() {
        vm.navigateToUploadImages = true
    }
}

struct AboutInterestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AboutInterestView()
                .environmentObject(PartnerHostingViewModel())
        }
    }
}
