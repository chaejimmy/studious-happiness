////
//  PartnerAddressSelectionView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct PartnerAddressSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var mapViewModel: MapViewModel
    @ObservedObject private var addressSearchViewModel = AddressSearchViewModel()
    @StateObject private var vm = PartnerHostingViewModel()
    @State private var enlargeMapView = false
    let locationManger = LocationManager()
    init(){
        mapViewModel = MapViewModel(location: locationManger)
    }
    var body: some View {
       
            ProposalWrapperView(isFooterVisible: !enlargeMapView,onBack: onBack, onNext: onNext) {
                content
            }
//            .navigationDestination(isPresented: $vm.navigateToAddressDescibe) {
//                PartnerAddressDescribeView()
//                    .environmentObject(vm)
//            }
        
    }
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !enlargeMapView {
                    HeaderView(
                        title: String.Constants.placeSelectionTitle,
                        subTitle: String.Constants.placeSelectionSubTitle
                    )
                    
                    AddressSearchTextField(viewModel: addressSearchViewModel, placeholder: String.Constants.enterPlaces)
                
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(mapViewModel.annotationItems, id: \.id) { place in
                                FeatureChipView(title: String(place.title.split(separator: ",")[0])){
                                    DispatchQueue.main.async {
                                        mapViewModel.removePlace(annotatioItem: place)
                                    }
                                }
                            }
                        }
                    }
                }
                MapWithPlacesListView(enlargeMapView: $enlargeMapView, isAppendItems: true)
                    .environmentObject(mapViewModel)
                    .environmentObject(addressSearchViewModel)
                
            }
            .padding([.top, .horizontal], 16)
        }
    }
    
    private func onNext() {
        DispatchQueue.main.async {
            vm.navigateToAddressDescibe = true
        }
    }
    private func onBack() {
        dismiss()
    }
}

struct PartnerAddressSelection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PartnerAddressSelectionView()
        }
    }
}


struct FeatureChipView: View {
    let title: String
    let action: ()-> Void
    var body: some View {
        HStack(spacing: 2) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
            Button {
                action()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 9, height: 9)
                    .padding(6)
                    .contentShape(Rectangle())
            }
        }
        .padding([.vertical, .trailing], 10)
        .padding(.leading)
        .foregroundColor(.black)
        .background(Color.darkWhite)
        .clipShape(Capsule())
    }
}
