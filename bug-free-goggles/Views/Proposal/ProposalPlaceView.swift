////
//  ProposalPlaceView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct ProposalPlaceView: View {
    @ObservedObject private var mapViewModel: MapViewModel

    @StateObject private var addressSearchViewModel = AddressSearchViewModel()
    @State private var enlargeMapView = false
    @State private var toShareView: Bool = false
    let locationManager = LocationManager()
    init() {
        mapViewModel = MapViewModel(location: locationManager)
    }
    var body: some View {
        ProposalWrapperView(
            isFooterVisible: !enlargeMapView,
            onNext: onNext
        ) {
            content
        }
        .navigationDestination(isPresented: $toShareView) {
            ProposalShareView()
        }
    }
    
    var content: some View{
        ScrollView {
            VStack {
                if !enlargeMapView {
                    HeaderView(
                        title: String.Constants.placeSelectionTitle,
                        subTitle: String.Constants.placeSelectionSubTitle
                    )
                    
                    AddressSearchTextField(viewModel: addressSearchViewModel)
                }
                
                MapWithPlacesListView(enlargeMapView: $enlargeMapView)
                    .environmentObject(mapViewModel)
                    .environmentObject(addressSearchViewModel)
            
            }
            .padding([.top, .horizontal], 16)
        }
    }
    
    func onNext() {
        toShareView = true
    }
}

struct ProposalPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProposalPlaceView()
        }
    }
}
