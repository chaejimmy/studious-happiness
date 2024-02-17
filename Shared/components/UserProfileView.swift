//
//  UserProfileView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

struct UserProfileView: View {
    var showImage: Bool
    var title: String
    var desc: String
    var actionPath: String
    var imagePath: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if showImage {
            Image(imagePath)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Label(title, image: "tickIcon")
                    .labelStyle(ReverseLabelStyle())
                    .padding(.top,7)
                Text(desc)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondaryGray)
            }
            Spacer()
            Button {
                
            } label: {
                Image(actionPath)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}

