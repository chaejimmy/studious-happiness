//
//  ListingCard.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct ListingsCard: View {
    let listing: ListingsModel
    
    var roomsMessage: String{
        listing.availableRooms > 1 ? "rooms available" : "room available"
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(listing.listingImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 110)
                
                VStack(alignment: .leading) {
                    Text(listing.listingName)
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text("\(listing.availableRooms) \(roomsMessage)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)
                    
                    RatingsView(rating: listing.rating)
                    
                    HStack {
                        Text(String(format: "%.0f$ / Night", listing.price))
                            .font(.callout.bold())
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("edit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                                .background(Color("DarkWhite"))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
                
            }
            .padding(.bottom, 2)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 4, y: 10)
                .shadow(color: .black.opacity(0.05), radius: 10, x: -4, y: -10)
            
        )
    }
}
