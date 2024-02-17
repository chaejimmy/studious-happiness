////
//  LocationView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/16/23.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var enlargeMapView = false
    @State private var selectedAddress: String?
    @ObservedObject private var addressSearchViewModel = AddressSearchViewModel()
    @ObservedObject private var mapViewModel = MapViewModel(location: LocationManager.shared)
    
    
    var body: some View {
        VStack {
            HeaderView(
                title: String.Hosting.placeSelectionTitle,
                subTitle: String.Hosting.placeSelectionSubTitle
            )
            
            // MARK: - PLACE SEARCH TEXTFIELD.
            AddressSearchTextField(viewModel: addressSearchViewModel)
                .padding(.bottom,5)
            
            MapView(viewModel: mapViewModel,
                    enlargeMapView: $enlargeMapView,
                     region: $mapViewModel.region,
                    height: getScreenBounds().height * 0.5)
                .overlay(  // MARK: - PLACE LIST
                    List(addressSearchViewModel.results) { address in
                        Button {
                            mapViewModel.getPlace(from: address) // To get Map region for selected address.
                            addressSearchViewModel.clear() // To clear search and dropPin
                            self.endEditing()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(address.title)
                                Text(address.subtitle)
                                    .font(.caption)
                            }
                        }
                        .padding(.bottom, 2)
                    } //: LIST
                        .listStyle(.plain)
                        .frame(minHeight: 100, maxHeight: 300)
                        .opacity(addressSearchViewModel.results.isEmpty ? 0 : 1)
                    
                    ,alignment: .top
                ) //: OVERLAY
            
            HStack {
                //back button
                BottomBackButtonView {
                    dismiss()
                }
                
                Spacer()
                
                // next button
                NavigationLink {
                    LookForView()
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle(
                    isDisable: selectedAddress == nil)
                )
                
                
            }//: HSTACK
            .padding(.vertical, 20)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
