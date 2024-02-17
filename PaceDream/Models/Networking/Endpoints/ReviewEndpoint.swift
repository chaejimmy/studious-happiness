////
//  ReviewEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to reviews
enum ReviewEndpoint: String, EndpointProtocol {
    case getAllReviews = "user/get-reviews-ratings"
    case addReviews = "user/add_review"
    case updateReview = "user/update_review"
    case softDeleteReview = "user/soft_del_review"
    case permanentDeleteReview = "user/perm_del_review"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        case .getAllReviews:
            return .get
        case .addReviews:
            return .post
        case .updateReview, .softDeleteReview:
            return .put
        case .permanentDeleteReview:
            return .delete
        }
    }
}
