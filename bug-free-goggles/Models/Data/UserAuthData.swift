////
//  UserAuthData.swift
//  bug-free-goggles
//
//  Created by Mac on 22/05/23.
//

import Foundation

//struct UserAuthData: Codable, Identifiable {
//    var id: String
//    var firstName: String
//    var lastName: String
//    var mobile: String
//    var token: String
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case mobile = "mobile"
//        case token = "token"
//    }
//}
// 

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
