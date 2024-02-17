//
//  HostAddressSelectionView.swift
//  bug-free-goggles
//
//  Created by Viswanath Reddy Ponthota on 05/05/23.
//

import SwiftUI
import MapKit

struct HostAddressSelectionView: View {
    
    // MARK: - PROPERIES
    @Environment(\.presentationMode) var presentationMode
    let locationManager =  LocationManager()
    @ObservedObject private var mapViewModel: MapViewModel
    @ObservedObject private var addressSearchViewModel = AddressSearchViewModel()
    
    @State private var enlargeMapView = false
    init() {
        mapViewModel =   MapViewModel(location: locationManager)
    }
    // MARK: - BODY
    var body: some View {
        
       // NavigationView {
           
                // MARK: - TOP HEADER
                VStack(alignment: .leading, spacing: 10) {
                    if !enlargeMapView {
                        HeaderView(
                            title: String.Hosting.placeSelectionTitle,
                            subTitle: String.Hosting.placeSelectionSubTitle
                        )
                        .padding(.top,70)
                        
                        // MARK: - PLACE SEARCH TEXTFIELD.
                        AddressSearchTextField(viewModel: addressSearchViewModel)
                            .padding(.bottom,5)
                    }
                    
                    // MARK: - MAPVIEW
                    
                    ZStack{
                        
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
                    }
                    .padding(.bottom, 10)
                     
                    // MARK: - BOTTOM CONTROLS VIEW
                    
                    if !enlargeMapView {
                       
                        HStack {
                            //back button
                            BottomBackButtonView {
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                            Spacer()
                            
                            // next button
                            NavigationLink {
                                AddressDescribeView()
                            } label: {
                                Text(String.Hosting.next)
                            }
                            .buttonStyle(secondaryButtonStyle(
                                isDisable: mapViewModel.selectedAddress == nil)
                            )
                            
                            
                        }//: HSTACK
                        .padding(.bottom, 80)
                        
                    }
                    
                }
                    .padding([.top, .horizontal], 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: .topLeading)

               

            .onAppear {
                mapViewModel.startUpdatingLocation()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CircleButton(size: 40, backgroundColor: .darkWhite) {
                        IconView(image: "chevron_left", size: 24)
                    } action: {
                        presentationMode.wrappedValue.dismiss()
                    }
                   
                }//: TOOL BAR ITEM
            }//: TOOLBAR
      //  } //: NAVIGATION
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct HostingPlaceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HostAddressSelectionView()
        }
    }
}
