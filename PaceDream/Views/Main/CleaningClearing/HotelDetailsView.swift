////
//  HotelDetailsView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct HotelDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var data: BookingData
    
    @ObservedObject private var mapViewModel:MapViewModel
    @State private var showUploadReview: Bool = false
    @State private var showCleaningView: Bool = false
    @State private var showUserProfile: Bool = false
    @State private var enlargeMapView = false
    var locationManger = LocationManager()
    init(data: BookingData){
        mapViewModel = MapViewModel(location: locationManger)
        self.data = data
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 8) {
//                CustomNavBar(title: data.roomData?.roomName ?? ""){
//                    dismiss()
//                }
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        if !enlargeMapView {
                            ImagePagerView(images: data.roomData?.imageList, dotSize: 6)
                                .overlay {
                                    ZStack(alignment: .bottomTrailing) {
                                        NavigationLink(destination: RoomLocationView(location: data.roomData?.location)) {
                                            Image("mapIcon")
                                                .frame(width: 24, height: 24)
                                                .padding(14)
                                                .background(Color.darkWhite2)
                                                .clipShape(Circle())
                                        }
                                        .padding(.trailing)
                                        .padding(.bottom, 22)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .opacity(data.roomData?.location == nil ? 0 : 1)
                                }
                            
                            Group {
                                NameAddressView(
                                    name: data.roomData?.roomName ?? "",
                                    address: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States"
                                )
                                
                                Divider()
                                    .frame(height: 4)
                                    .background(Color.darkWhite)
                                
                                reviewAndCleaningView
                                Divider()
                                    .frame(height: 4)
                                    .background(Color.darkWhite)
                                GridArrangeView(list: data.roomData?.roomDetailes ?? [])
                                    .padding()
                                    .background(Color.white)
                                Divider()
                                    .frame(height: 4)
                                    .background(Color.darkWhite)
                                UserProfileButtonView(image: "", name: "Michealy Dam", address: "CA, United States."){
                                    showUserProfile = true
                                }
                                .padding()
                                .background(Color.white)
                                Divider()
                                    .frame(height: 4)
                                    .background(Color.darkWhite)
                            }
                        }
                        MapView(viewModel: mapViewModel, enlargeMapView: $enlargeMapView, region: $mapViewModel.region, height: 200)
                            .padding()
                    }
                }
            }
        }
        //.toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $showUploadReview) {
            ReviewUploadView()
        }.navigationDestination(isPresented: $showCleaningView) {
            CleaningClearingView(isForCleaning: true)
        }.navigationDestination(isPresented: $showUserProfile) {
            ProfileView(roomMate: PreviewData.roomMateData)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(data.roomData?.roomName ?? "test")
    }
    
    var reviewAndCleaningView: some View {
        HStack(spacing: 16) {
            Button {
                showUploadReview = true
            } label: {
                Text("Submit Review")
                    .font(.system(size: 13, weight: .semibold))
            }
            .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
            
            Button {
                showCleaningView = true
            } label: {
                Text("Claim Cleaning Fees")
                    .font(.system(size: 13, weight: .semibold))
            }
            .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

struct HotelDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HotelDetailsView(data: PreviewData.bookingData)
    }
}
