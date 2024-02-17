////
//  AuthEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to authentication
enum AuthEndpoint: String, EndpointProtocol {
    case checkEmail = "auth/signup/check-email"
    case sendOtp = "auth/sendotp"
    case verifyOtp = "auth/verify-otp"
    case signUp = "auth/signup"
    case login = "auth/login"
    case googleLogin = "auth/google"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }

    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        default:
            return .post
        }
    }
}


