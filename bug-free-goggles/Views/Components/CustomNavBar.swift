////
//  CustomNavBar.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct CustomNavBar: View {
    var title: String
    var isVerified: Bool = false
    let backAction: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button {
                backAction()
            } label: {
                Image("arrowBackIcon")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(8)
            }
            
            HStack(spacing: 4) {
                Text(title)
                    .font(.circular(size: 17, weight: .medium))
                if isVerified {
                    Image("tickIcon")
                        .frame(width: 14, height: 14)
                        .foregroundColor(.white)
                }
                 Spacer()
            }
            Button {
                
            } label: {
                Image("moreIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(title: "Hotel Huntington", backAction: {})
    }
}
