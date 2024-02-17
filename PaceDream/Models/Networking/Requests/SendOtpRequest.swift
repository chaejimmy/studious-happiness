////
//  SendOtpRequest.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import Foundation

struct SendOtpRequest: Codable {
    var mobile: String
    
    enum CodingKeys: CodingKey {
        case mobile
    }
    
    func getAPIBody() -> Data? {
        let json: [String : CustomStringConvertible] = [
            "mobile": mobile
        ]
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
