////
//  BookedDetailsView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct BookedDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var showBookNowSheet: Bool = false
    @State var selectedFacility: FacilityType = .shereWithRoommate
    
    let data: BookingData
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 8) {
                CustomNavBar(title: data.roomData?.roomName ?? ""){
                    dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
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
                        
                        NameAddressView(
                            name: data.roomData?.roomName ?? "",
                            address: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States"
                        )
                        
                        GridArrangeView(list: data.roomData?.roomDetailes ?? [])
                            .padding()
                            .background(Color.white)
                            .padding(.top, 4)
                        
                        if let roomMate = data.roomMateData {
                            UserDescriptionView(roomMate: roomMate)
                                .padding(.top, 4)
                        }
                        
                        FacilitiesView()
                            .padding(.top, 4)
                        CompatibleNoteView()
                            .padding(.top, 4)
                        
                        Spacer(minLength: 100)
                    }
                    .background(Color.darkWhite)
                }
                
            }
            ImageTextButton(label: "Book Now", image: "bookNowIcon"){
                showBookNowSheet = true
            }
            .padding()
            .background(Color.white)
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showBookNowSheet) {
            BookNowSheet()
        }
    }
    
    func UserDescriptionView(roomMate: RoommateData) -> some View {
        VStack(spacing: 16) {
            UserProfileView(
                image: roomMate.images?[0].url ?? "",
                name: roomMate.name,
                address: roomMate.address,
                size: 52
            )
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
    
    func FacilitiesView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Compatible with")
                .font(.system(size: 17, weight: .semibold))
            VStack(spacing: 0) {
                ForEach(FacilityType.allCases, id: \.title) { facility in
                    FacilityItemView(title: facility.title, isChecked: selectedFacility == facility){
                        selectedFacility = facility
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct BookedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookedDetailsView(data: PreviewData.bookingData)
    }
}

enum FacilityType: CaseIterable {
    case shereWithRoommate
    case hourlyRent
    case shareWithPartner
    
    var title: String {
        switch self {
        case .shereWithRoommate: return "Share with Roommate"
        case .hourlyRent: return "Hourly Rent"
        case .shareWithPartner: return "Share With Partner"
        }
    }
}

struct FacilityItemView: View {
    let title: String
    var isChecked: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if isChecked {
                    Image("checkIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                } else {
                    Rectangle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .strokeBorder(Color.darkGray)
                        }
                }
                Text(title)
                    .style(.body)
                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}
