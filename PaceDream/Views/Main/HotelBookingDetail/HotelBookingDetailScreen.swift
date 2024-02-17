////
//  HotelBookingDetailScreen.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

struct HotelBookingDetailScreen: View {
    var body: some View {
        VStack {
            imagePagerSection
            
            Spacer()
        }
    }
    
    private var imagePagerSection: some View {
        VStack {
            GeometryReader { bounds in
                ImagePagerView(images: ["onboard1", "onboard2", "onboard3"], height: bounds.size.height, dotSize: 8)
            }
            .aspectRatio(1, contentMode: .fit)
            
            
            VStack(spacing: 8) {
                Text("Hotel Huntington")
            }
        }
    }
}

struct HotelBookingDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        HotelBookingDetailScreen()
    }
}
