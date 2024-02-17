////
//  BigImageView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct BigImageView: View {
    var image: UIImage
    let deleteAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 156)
            
            Color.black.opacity(0.2)
            
            Button {
                deleteAction()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 22, height: 22)
                    .foregroundColor(.gray700)
                    .fontWeight(.semibold)
                    .padding(12)
                    .background(Color.darkWhite2)
                    .clipShape(Circle())
            }
            .padding(10)

        }
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.neutral700, style: StrokeStyle(lineWidth: 2))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
