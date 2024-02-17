////
//  BookedPostView.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI
import Kingfisher

struct BookedPostView: View {
    let data: BookingData
    let deleteClicked: (()->Void)?
    let editClicked: (()->Void)?
    let isMyProfile: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                UserProfileView(
                    image: data.roomMateData?.images?[0].url ?? "",
                    name: data.roomMateData?.name ?? "",
                    address: data.roomMateData?.address ?? ""
                )
                Spacer()
//                if isMyProfile {
//                    Menu {
//                        Button(role: .destructive) { deleteClicked!()  } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                        Button(role: .none) { editClicked!() } label: {
//                            Label("Edit", systemImage: "pencil")
//                        }
//                        
//                    } label: {
//                        Image("moreIcon")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                        
//                    }
//                }
            }
            ImagePagerView(images: data.roomData?.imageList, height: 255)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(data.roomData?.roomName ?? "")
                    .font(.circular(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text(data.roomData?.roomDescription ?? "")
                    .font(.circular(size: 13, weight: .book))
                    .foregroundColor(.secondaryGray)
                    .padding(.top, 2)
                Text(data.roomData?.dateRange ?? "")
                    .font(.circular(size: 13, weight: .book))
                    .foregroundColor(.secondaryGray)
                
                HStack(spacing: 4) {
                    Text("$\(data.payment.amount)/Night")
                        .font(.circular(size: 15, weight: .book))
                        .foregroundColor(.black)
                    Spacer()
                    Text("Booked")
                        .font(.circular(size: 13, weight: .book))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .foregroundColor(.secondaryGray)
                        .background(
                            Capsule()
                                .fill(Color.lightGray)
                        )
                }
                .padding(.top, 2)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

struct PostImageItem: View {
    var title: String
    //URL(string: title)
    var body: some View {
        KFImage.url(URL(string:"https://res.cloudinary.com/expert-tracker/image/upload/v1689193373/cleanhomepic_vdd3y6.jpg"))
            .resizable()
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in }
            .placeholder { _ in
                Color.darkWhite
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
             
//        AsyncImage(url: URL(string: "https://res.cloudinary.com/expert-tracker/image/upload/v1689193373/cleanhomepic_vdd3y6.jpg")) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        } placeholder: {
//            Color.darkWhite
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UnavailablePostView: View {
    let roomMate: RoommateData
    var editClicked: (() -> Void)
    var deleteClicked: (() -> Void)
    let isMyProfile: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImagePagerView(images: roomMate.imageList, height: 285)
            
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Label(roomMate.name, image: "tickIcon")
                        .labelStyle(ReverseLabelStyle())
                    Text(roomMate.address)
                        .font(.circular(size: 13, weight: .book))
                        .foregroundColor(.secondaryGray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                if isMyProfile {
                    Menu {
                        Button(role: .destructive) { deleteClicked() } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(role: .none) { editClicked() } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                    } label: {
                        Image("moreIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                    }
                    
                }
            }
            .padding(.top, 4)
            
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Looking Places: Bristol, Bath & London")
                    .font(.circular(size: 15, weight: .book))
                    .foregroundColor(.black)
                Text("Available from 20th March, 2023")
                    .font(.circular(size: 13, weight: .book))
                    .foregroundColor(.secondaryGray)
                
                HStack(spacing: 4) {
                    Text("$650/Night")
                        .font(.circular(size: 15, weight: .book))
                        .foregroundColor(.black)
                    Spacer()
                    Text("Unavailable")
                        .font(.circular(size: 13, weight: .book))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .foregroundColor(.secondaryGray)
                        .background(
                            Capsule()
                                .fill(Color.lightGray)
                        )
                }
                .padding(.top, 2)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
}

struct BookPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ScrollView {
                BookedPostView(data: PreviewData.bookingData,deleteClicked: {
                    //
                }, editClicked: {},isMyProfile: true)
                UnavailablePostView(roomMate: PreviewData.roomMateData,editClicked: {},deleteClicked: {},isMyProfile: true)
            }
        }
    }
}

struct ImagePagerView: View {
    var images: [String]?
    var height: CGFloat = 360
    var dotSize: CGFloat = 4
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let images = images {
                TabView(selection: $selectedIndex) {
                    if images.count > 0 {
                        ForEach(images.indices, id: \.self) { i in
                            //PostImageItem(title: images[i])
                            PostImageItem(title: "https://res.cloudinary.com/expert-tracker/image/upload/v1689193373/cleanhomepic_vdd3y6.jpg")
                                .tag(i)
                        }
                    }else {
                        PostImageItem(title: "https://res.cloudinary.com/expert-tracker/image/upload/v1689193373/cleanhomepic_vdd3y6.jpg")
                            .tag(1)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: height)
                
                HStack(spacing: dotSize) {
                    ForEach(images.indices, id: \.self) { i in
                        Circle()
                            .frame(width: dotSize, height: dotSize)
                            .foregroundColor(.white.opacity(selectedIndex == i ? 1 : 0.2))
                    }
                }
                .padding(.bottom, 18)
            } else {
                Color.darkWhite
            }
        }
        .frame(height: height)
    }
}
