////
//  PartnerImageUploadView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct PartnerImageUploadView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        ProposalWrapperWithHeaderView(
            title: String.Hosting.uploadImagePageTitle,
            subtitle: String.Constants.uploadAtleastFourImage,
            isNextDisable: vm.uploadImageValidation,
            onNext: onNext
        ) {
            PickImageListView(selectedImages: $vm.selectedImages)
        }
        .navigationDestination(isPresented: $vm.navigateToGiveATitle) {
            PartnerGiveATitleView()
                .environmentObject(vm)
        }
    }
    
    func onNext() {
        vm.navigateToGiveATitle = true
    }
}

struct PartnerImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PartnerImageUploadView()
                .environmentObject(PartnerHostingViewModel())
        }
    }
}
