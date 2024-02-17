////
//  WishListView.swift
//  bug-free-goggles
//
//  Created by Mac on 23/07/2023.
//

import SwiftUI

struct WishListView: View {
     
         
    let homes:  [Home] = [
        Home(id: 3, name: "Wishlist Home 1", image: "hotel1", isWishlist: true),
        Home(id: 4, name: "Wishlist Home 2", image: "image3", isWishlist: true),
        Home(id: 1, name: "Reserved Home 1", image: "moc_hotel", isWishlist: false),
        Home(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),
        Home(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),
        Home(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),

    ]
    @ViewBuilder
    var noWishListview: some View {
        VStack(spacing: 5) {
            Image("wishlistIcon")
                .resizable()
                .frame(width: 70, height: 70)
            Text("No wishlists yet")
                .font(.title2)
                .bold()
            
        }
        
    }
   
    @Binding var navigation: Bool
    var body: some View {
        if  homes.isEmpty {
            noWishListview
                .frame(alignment: .center)
        } else {
            VStack {
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)], spacing: 8) {
                        ForEach(homes) { home in
                            ListingCardView(home: home)
                                .onTapGesture {
                                    navigation.toggle()
                                }
                        }
                    }
                }
                
            }.padding(5)
        }
    }
}

struct Home: Identifiable {
    let id: Int
    let name: String
    let image: String
    let isWishlist: Bool
}
struct ListingCardView: View {
    let home: Home // Assuming `Home` is the data model for the listing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(home.image)
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .clipped()
                .cornerRadius(12)
            
            Text(home.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            if home.isWishlist {
                Text("Wishlist")
                    .font(.caption)
                    .foregroundColor(.blue)
            } else {
                Text("Reserved")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView(navigation: .constant(true))
    }
}
