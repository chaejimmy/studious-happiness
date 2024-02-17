////
//  UserAuthData.swift
//  bug-free-goggles
//
//  Created by Mac on 22/05/23.
//

import Foundation
  
struct CheckEmailData: Codable {
    var action: String?
    var code: Int?
    var status: Bool?
    var data: CheckEmailError?
}

struct CheckEmailError: Codable {
    let error: String?
}


struct SignUpEmailData: Codable {
    var action: String?
    var code: Int?
    var status: Bool?
    var data: SignUpUserData?
}

struct SignUpUserData: Codable {
    let token: String?
    let first_name: String?
    let last_name: String?
    let user_id: String?
    let role_id: Int?
    let email: String?
    let emailVerified: Bool?
    let error: String?
}
  


// MARK: - UserAuthData
struct UserAuthData: Codable {
    var action: String?
    var code: Int?
    var status: Bool?
    var data: UserInfoData?
    var message: String?
}

// MARK: - DataClass
struct UserInfoData: Codable {
    var token, firstName, lastName, userID: String?
    var roleID: Int?

    enum CodingKeys: String, CodingKey {
        case token
        case firstName = "first_name"
        case lastName = "last_name"
        case userID = "user_id"
        case roleID = "role_id"
    }
}
