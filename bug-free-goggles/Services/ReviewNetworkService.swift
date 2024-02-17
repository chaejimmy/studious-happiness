////
//  ReviewNetworkService.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

class ReviewNetworkService{
    
    private func createQueryParameter(for id: ReviewData.ID) -> [String: String]{
        let queryParams = [
            "review_id": id
        ]
        return queryParams
    }
    
    func getAllReviews() async -> [ReviewData]{
        let endpoint = Endpoint(ReviewEndpoint.getAllReviews)
        do {
            let response: Response<ReviewNetworkResponse> = try await NetworkUtility.shared.request(endpoint: endpoint)
            let reviewResonse = try response.getData()
            guard let reviewResonseData = reviewResonse else {
                throw APIError(statusCode: -1, message: "Invalid Data")
            }
            let reviews = reviewResonseData.review
            return reviews
        }
        catch {
            print(error)
            return []
        }
    }
    
    func addReview(payload: ReviewData.AddPayload) async throws -> SuccessMessage {
        let endpoint = Endpoint(ReviewEndpoint.addReviews)
        let response: SuccessMessage = try await NetworkUtility.shared.request(endpoint: endpoint)
        return response
    }
    
    
    func updateReview(id: ReviewData.ID, payload: ReviewData.UpdatePayload) async throws -> ReviewData.UpdateResponse?{
        let endpoint = Endpoint(ReviewEndpoint.updateReview)
        let response: Response<ReviewData.UpdateResponse> = try await NetworkUtility.shared.request(endpoint: endpoint)
        let data = try response.getData()
        return data
    }
    
    func softDeleteReview(id: ReviewData.ID) async throws -> ReviewData.DeleteResponse?{
        let endpoint = Endpoint(ReviewEndpoint.softDeleteReview)
        let queryParams = createQueryParameter(for: id)
        let response: Response<ReviewData.DeleteResponse> = try await NetworkUtility.shared.request(endpoint: endpoint, queryParams: queryParams)
        let data = try response.getData()
        return data
    }
    
    func permanentDeleteReview(id: ReviewData.ID) async throws -> ReviewData.DeleteResponse?{
        let endpoint = Endpoint(ReviewEndpoint.permanentDeleteReview)
        let queryParams = createQueryParameter(for: id)
        let response: Response<ReviewData.DeleteResponse> = try await NetworkUtility.shared.request(endpoint: endpoint, queryParams: queryParams)
        let data = try response.getData()
        return data
    }
}
