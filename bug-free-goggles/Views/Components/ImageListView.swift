////
//  ImageListView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct ImageListView: View {
    @Binding var images: [UIImage]
    let pickImages: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            EmptyImageButton(){
                pickImages()
            }
            ForEach(images, id: \.self) { image in
                BigImageView(image: image) {
                    if let i = images.firstIndex(of: image) {
                        images.remove(at: i)
                    }
                }
            }
        }
    }
}

struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView(images: .constant([])){}
    }
}
