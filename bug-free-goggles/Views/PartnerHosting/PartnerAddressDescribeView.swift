////
//  PartnerAddressDescribeView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct PartnerAddressDescribeView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        ProposalWrapperView(isNextDisable: vm.addressDescribeValidation, onNext: onNext) {
            content
        }
        .navigationDestination(isPresented: $vm.navigateToAboutInterests) {
            AboutInterestView()
                .environmentObject(vm)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderView(
                title: String.Constants.partnerDetailTitle,
                subTitle: String.Constants.placeSelectionSubTitle
            )
            .padding(.horizontal)
            
            LabelView(title: "Sharable Details"){
                StepperRowView(
                    title: String.Constants.guests,
                    stepValue: $vm.guestCount,
                    spacing: 10
                )
                .padding(.horizontal)
            }
            
            LabelView(title: String.Constants.partnerDetailTitle){
                HStack(spacing: 8) {
                    ForEach(GenderType.allCases, id: \.title) { gender in
                        ChipView(
                            title: gender.canStay,
                            bgColor: .appPrimary,
                            isSelected: vm.selectedGender == gender
                        ) {
                            withAnimation(.easeInOut) {
                                vm.selectedGender = gender
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            LabelView(title: String.Constants.pets){
                HStack(spacing: 8) {
                    ForEach(PetsSelectionType.allCases, id: \.title) { petSelection in
                        ChipView(
                            title: petSelection.title,
                            imageName: petSelection.image,
                            bgColor: .appPrimary,
                            isSelected: vm.selectedPets == petSelection
                        ) {
                            withAnimation(.easeInOut) {
                                vm.selectedPets = petSelection
                            }
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .padding(.top)
    }
    
    func onNext() {
        vm.navigateToAboutInterests = true
    }
}


struct LabelView<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.lightGrayText)
                .padding(.leading)
            
            content
                .padding(.bottom, 8)
        }
    }
}

struct PartnerAddressDescribeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PartnerAddressDescribeView()
                .environmentObject(PartnerHostingViewModel())
        }
    }
}
