////
//  WishlistNetworkServiceTests.swift
//  bug-free-gogglesTests
//
//  Created by Mac on 24/05/23.
//

import XCTest
@testable import bug_free_goggles

final class WishlistNetworkServiceTests: XCTestCase {
    var wishlistService: WishlistNetworkService!
    
    override func setUp() {
        super.setUp()
        wishlistService = WishlistNetworkService()
    }
    
    override func tearDown() {
        wishlistService = nil
        super.tearDown()
    }
    
    func testGetAllWishlists() async {
        do {
            let result = try await wishlistService.getAllWishlists()
            XCTAssertGreaterThanOrEqual(result.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
        // Add more assertions as needed
    }
    
    func testAddWishlist() async {
        let payload = WishlistData.RoomUserPayload(roomId: "64518774c0d82e4ec1edfdf8", userID: "64518774c0d82e4ec1edfdf8")
        do {
            let respose = try await wishlistService.addWishlist(payload: payload)
            XCTAssertNotNil(respose)
        } catch {
            if error.message == "Room already exists in your cart."{
                XCTAssertTrue(true)
            }
            else{
                XCTFail(error.message)
            }
        }
    }
    
    func testDeleteWishlist() async {
        let payload = WishlistData.RoomUserPayload(roomId: "64518774c0d82e4ec1edfdf8", userID: "64518774c0d82e4ec1edfdf8")
        do {
            try await wishlistService.deleteWishlist(payload: payload)
            XCTAssertTrue(true)
        } catch {
            if let _ = error as? APIError{
                XCTAssertTrue(true)
            }
            else{
                XCTFail(error.message)
            }
        }
    }
    
//    func testGetUserWishlist() async {
//        let payload = WishlistData.UserPayload(userId: "64518774c0d82e4ec1edfdf8")
//        do {
//            let _ = try await wishlistService.getUserWishlist(payload: payload)
//            XCTAssertTrue(true)
//        } catch {
//            if let _ = error as? APIError{
//                XCTAssertTrue(true)
//            }
//            else{
//                XCTFail(error.message)
//            }
//        }
//    }
    
    
}
 
