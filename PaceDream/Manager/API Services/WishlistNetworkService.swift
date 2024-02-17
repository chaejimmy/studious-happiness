////
//  WishlistNetworkService.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

class WishlistNetworkService{
    private let networkUtility = NetworkUtility.shared
    
    func getAllWishlists() async throws -> [WishlistData]{
        let endpoint = Endpoint(WishlistEndpoint.getAllWishlist)
        let response: Response<[WishlistData]> = try await networkUtility.request(endpoint: endpoint)
        let wishlists = try response.getObject()
        return wishlists
    }
    
    func addWishlist(payload: WishlistData.RoomUserPayload) async throws -> WishlistData? {
        let endpoint = Endpoint(WishlistEndpoint.addWishlist)
        let (data, _) = try await networkUtility.request(endpoint: endpoint, body: payload)
        if let response: Response<WishlistData> = JSONUtility.getObject(from: data),
           let wishlist = response.data{
            return wishlist
        }
        else if let response: Response<WishlistData.AddResponse> = JSONUtility.getObject(from: data),
                let addResponse = response.data{
            throw APIError(statusCode: -1, message: addResponse.msg)
        }
        else{
            throw APIError(statusCode: -1, message: "Invalid data")
        }
    }
    
    func deleteWishlist(payload: WishlistData.RoomUserPayload) async throws {
        let endpoint = Endpoint(WishlistEndpoint.deleteWishlist)
        let response: Response<WishlistData.UpdateResponse> = try await networkUtility.request(endpoint: endpoint)
        let updateResponse = try response.getObject()
        if let error = updateResponse.errors{
            throw APIError(statusCode: response.code, message: error)
        }
    }
    
    func getUserWishlist(payload: WishlistData.UserPayload) async throws -> [WishlistData]{
        let endpoint = Endpoint(WishlistEndpoint.getUserWishlist)
        let response: Response<[WishlistData]> = try await networkUtility.request(endpoint: endpoint)
        let wishlists = try response.getObject()
        return wishlists
    }
    
    func wishlistCount(payload: WishlistData.UserPayload) async throws -> WishlistCount{
        let endpoint = Endpoint(WishlistEndpoint.wishlistCount)
        let response: Response<WishlistCount> = try await networkUtility.request(endpoint: endpoint)
        let count = try response.getObject()
        return count
    }
    
}
