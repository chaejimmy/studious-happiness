//
//  AuthModel.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 16/05/2023.
//

import SwiftUI


struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var token: String?
    var isLogged: Bool?
    var message: String?
}

struct UserApiData: Codable {
    var login: Bool
    var data: User?
    var message: String
    var token: String?
}
