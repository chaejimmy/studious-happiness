////
//  ImageTextButton.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct ImageTextButton: View {
    let label: String
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(label)
                    .font(.system(size: 17, weight: .semibold))
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundColor(.white)
            .background(Color.appPrimary)
            .clipShape(Capsule())
        }
        
    }
}

struct ImageTextButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextButton(label: "Book Now", image: "bookNowIcon", action: {})
    }
}
