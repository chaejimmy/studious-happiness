////
//  LoginRequest.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation
  
struct EmailLoginRequest: Codable {
    var email: String
    var password: String
      
    public func getAPIBody() -> Data? {
        
        let json: [String : CustomStringConvertible] = [
            "method": "email",
            "email": email,
            "password": password
        ]
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
 
//"email": "vipin1@gmail.com",
//   "password": "admin@123"


struct PhoneLoginRequest: Codable {
    var mobile: String
    
    public func getAPIBody() -> Data? {
        
        let json: [String : CustomStringConvertible] = [
            "method": "mobile",
            "mobile": mobile
        ]
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
