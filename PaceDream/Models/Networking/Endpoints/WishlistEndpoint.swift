////
//  WishlistEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to wishlists
enum WishlistEndpoint: String, EndpointProtocol {
    case getAllWishlist = "user/get_wishlist"
    case addWishlist = "user/add-wishlist"
    case deleteWishlist = "user/delete-wishlist"
    case getUserWishlist = "user/get_user_wishlist"
    case wishlistCount = "user/wishlist_count"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        case .getAllWishlist, .getUserWishlist, .wishlistCount:
            return .get
        case .addWishlist, .deleteWishlist:
            return .post
        }
    }
}
