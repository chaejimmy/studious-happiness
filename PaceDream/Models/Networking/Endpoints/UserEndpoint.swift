////
//  UserEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to users
enum UserEndpoint: String, EndpointProtocol {
    case allUsers = "user/get_all_users"
    case addUser = "add_user"
    case updateUser = "user/update_user"
    case softDelUser = "user/soft_del_user"
    case deleteUser = "user/perm_del_user"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        case .allUsers:
            return .get
        case .addUser:
            return .post
        case .updateUser, .softDelUser:
            return .put
        case .deleteUser:
            return .delete
        }
    }
}
