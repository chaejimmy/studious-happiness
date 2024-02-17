//
//  ReviewItemView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 12/05/2023.
//

import SwiftUI

struct ReviewItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            UserProfileView(showImage: true, title: "Stella Williams", desc: "Bristol, United Kingdom",actionPath: "moreIcon",imagePath: "oval5")
            VStack(spacing: 8) {
                RatingStarView(fullStarCount: 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\"Living with Stella Williams has been awesome! She’s a respectful and considerate roommate who keeps home clean and organised.\"")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 12) {
                Image("onboard1")
                    .resizable()
                    .frame(width: 86, height: 57)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Brunel's SS Great Britain")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Text("Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.secondaryGray)
                }
            }
            
            Text("12th Feb, 2023")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondaryGray)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

struct RatingStarView: View {
    let fullStarCount: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { i in
                Image(i <= fullStarCount ? "fullStarIcon" : "emptyStarIcon")
                    .frame(width: 15, height: 15)
            }
        }
    }
}

struct ReviewItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewItemView()
    }
}
