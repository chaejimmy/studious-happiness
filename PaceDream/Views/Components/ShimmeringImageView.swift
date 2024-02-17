////
//  ShimmeringImageView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/10/23.
//

import SwiftUI
import URLImage
import Shimmer

struct ShimmeringImageView: View {
    let imageURL: URL
    
    var body: some View {
       
                     
            URLImage(imageURL) {
                
                EmptyView()
            } inProgress: { progress in
                Rectangle()
                     .shimmering(
                         active: true,
                         animation: .easeInOut(duration: 2).repeatCount(20, autoreverses: false).delay(1),
                         gradient: Gradient(colors: [Color.lightGray, Color.gray,Color.lightGray])
                     ).foregroundColor(Color.gray)
            } failure: { error, retry in
               
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry", action: retry)
                }
            } content: { image in
                // Downloaded image
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

        
            
        }
    
}

struct ShimmeringImageView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmeringImageView(imageURL: URL(string: "https://images.pexels.com/photos/6466236/pexels-photo-6466236.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load")!)
    }
}

