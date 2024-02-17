//
//  SpaceViewModel.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import Foundation

class SpaceViewModel: ObservableObject{
    @Published var listings: [ListingsModel] = [
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
        ListingsModel(listingImage: "ListingImage", listingName: "Cerulean Tower Hotel", availableRooms: 2, rating: 4.5, price: 75),
    ]
    
    @Published var claims: [ClaimsModel] = [
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        ClaimsModel(claimImage: "ListingImage", claimName: "Cerulean Tower Hotel", claimDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", price: 75),
        
    ]
}

enum SpaceTab: Int, CaseIterable{
    case listings = 0
    case claims
    
    var title: String{
        switch self {
        case .listings: return "Listings"
        case .claims: return "Claims"
        }
    }
}
