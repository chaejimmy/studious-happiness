////
//  UserProfileView.swift
//  bug-free-goggles
//
//  Created by Mac on 05/05/23.
//

import SwiftUI
import Kingfisher

struct UserProfileMoreView: View {
    var image: String
    var name: String
    var address: String
    var size: CGFloat = 48
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            UserProfileView(image: image, name: name, address: address, size: size)
            Button {
                
            } label: {
                Image("moreIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
           
        }
    }
}

struct UserProfileButtonView: View {
    var image: String
    var name: String
    var address: String
    var size: CGFloat = 48
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            UserProfileView(image: image, name: name, address: address, size: size)
            Button {
                action()
            } label: {
               Text("View Profile")
            }
            .font(.circular(size: 15, weight: .medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .background(.black)
            .clipShape(Capsule())
        }
    }
}

struct UserProfileView: View {
    var image: String = "https://res.cloudinary.com/expert-tracker/image/upload/v1690673670/sampleprofileimage_xrh0sz.jpg"
    var name: String
    var address: String
    var size: CGFloat = 80
   @State var isActive: Bool = true
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                KFImage.url(URL(string:"https://res.cloudinary.com/expert-tracker/image/upload/v1690673670/sampleprofileimage_xrh0sz.jpg"))
                    .resizable()
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .placeholder { _ in
                        Image("personIcon")
                            .resizable()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                ActiveIndicatorView(isActive: $isActive)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Label(name, image: "tickIcon")
                    .labelStyle(ReverseLabelStyle())
                    .padding(.top, 4)
                Text(address)
                    .font(.circular(size: 15, weight: .book))
                    .foregroundColor(.secondaryGray)
                Text("Member since may 02,2023")
                    .font(.circular(size: 13, weight: .light))
                    .foregroundColor(.secondaryGray)
                     
                
            }.padding(.top,5)
            Spacer()
        }
    }
}
struct ActiveIndicatorView: View {
    @Binding var isActive: Bool
    var body: some View {
        Circle()
            .foregroundColor(isActive  ? .green : .lightGreen)
            .frame(width: 10, height: 10)
    }
}
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UserProfileMoreView(image: "", name: "Michealy Dam", address: "CA, United States.")
            UserProfileView(image: "", name: "Michealy Dam", address: "CA, United States.")
            UserProfileButtonView(image: "", name: "Michealy Dam", address: "CA, United States."){}
        }
    }
}
