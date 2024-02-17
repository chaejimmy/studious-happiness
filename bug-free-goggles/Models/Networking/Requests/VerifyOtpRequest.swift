////
//  VerifyOtpRequest.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import Foundation

struct VerifyOtpRequest: Codable {
    let mobile: String
    let otp: String
    
    enum CodingKeys: String, CodingKey {
        case mobile
        case otp
    }
    
    func getAPIBody() -> Data? {
        let json: [String : CustomStringConvertible] = [
            "otp": otp,
            "mobile": mobile
        ]
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
