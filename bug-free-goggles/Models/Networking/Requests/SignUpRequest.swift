////
//  SignUpRequest.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import Foundation

struct PhoneSignUpRequest: Codable {
    var method: String = "custom_phone"
    var mobile: String
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    var birthDate: String
    var gender: String
    
    enum CodingKeys: String, CodingKey {
        case method
        case mobile
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case birthDate = "date_of_birth"
        case gender
    }
  
    func getAPIBody() -> Data? {
        let json: [String : CustomStringConvertible] = [
            "method": method,
            "mobile": mobile,
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "password": password,
            "date_of_birth": birthDate,
            "gender": gender
        ]
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
