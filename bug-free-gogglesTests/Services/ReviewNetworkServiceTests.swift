////
//  ReviewNetworkServiceTests.swift
//  bug-free-gogglesTests
//
//  Created by Mac on 24/05/23.
//

import XCTest
@testable import bug_free_goggles

final class ReviewNetworkServiceTests: XCTestCase {
    
    var reviewService: ReviewNetworkService!
    
    override func setUp() {
        super.setUp()
        reviewService = ReviewNetworkService()
    }
    
    override func tearDown() {
        reviewService = nil
        super.tearDown()
    }
    
    func testGetAllReviews() async {
        let reviews = await reviewService.getAllReviews()
        XCTAssertGreaterThan(reviews.count, 0, "Reviews should not be Empty")
    }
    
    func testAddReview() async {
        let payload = ReviewData.AddPayload(rating: 4, comment: "Very good room.")
        do {
            let response = try await reviewService.addReview(payload: payload)
            XCTAssertNotNil(response, "Response should not be nil")
        } catch {
            guard let apiError = error as? APIError,
                  let _: SuccessMessage = apiError.getObject()
            else {
                XCTFail(error.localizedDescription)
                return
            }
            XCTAssertTrue(true)
        }
    }
    
    func testUpdateReview() async {
        let reviewID = "your_review_id"
        let payload = ReviewData.UpdatePayload(ratings: 5, comment: "Yes! yoo mohol bro.", status: 1)
        do {
            let response = try await reviewService.updateReview(id: reviewID, payload: payload)
            dump(response)
            XCTAssertNotNil(response, "Response should not be nil")
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSoftDeleteReview() async {
        let reviewID = "63e4ff2708f1d5eb0641cad1"
        do {
            let response = try await reviewService.softDeleteReview(id: reviewID)
            XCTAssertNotNil(response, "Response should not be nil")
        } catch {
            XCTFail(error.localizedDescription)
        }
   
    }
    
    func testPermanentDeleteReview() async throws {
        let reviewID = "64518d0da1df27c295b0db51"
        do {
            let response = try await reviewService.permanentDeleteReview(id: reviewID)
            XCTAssertNotNil(response, "Response should not be nil")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
}
