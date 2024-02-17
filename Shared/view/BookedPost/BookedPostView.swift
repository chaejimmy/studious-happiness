//
//  BookedPostView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

struct BookedPostView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            UserProfileView(showImage: true,title: "Michealy Dam", desc: "CA, United States.",actionPath: "moreIcon",imagePath: "Oval2")

            TabView {
                PostImageItem(title: "onboard1")
                PostImageItem(title: "onboard2")
                PostImageItem(title: "onboard3")
            }
            .tabViewStyle(.page)
            .frame(height: 255)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Brunel's SS Great Britain")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text("Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondaryGray)
                    .padding(.top, 2)
                Text("25 Jan - 27 Jan")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondaryGray)
                
                HStack(spacing: 4) {
                    Text("$650/Night")
                        .font(.system(size: 15, weight: .regular))
                    Spacer()
                    Text("Booked")
                        .font(.system(size: 13, weight: .regular))
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
    
    var body: some View {
        Image(title)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct BookPostView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BookedPostView()
        }
    }
}
