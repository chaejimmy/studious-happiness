////
//  ProfileEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to profiles
enum ProfileEndpoint: String, EndpointProtocol {
    case getProfiles = "user/get_all_roomates"
    case getRoomates = "user/get_roomates"
    case addRoomate = "user/add_roomate"
    case updateRoomateProfile = "user/update_roomate_profile"
    case deleteRoomate = "user/perm_del_roomate"
    
    /// The path of the endpoint
    var path: String {
        return rawValue
    }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod_Enum {
        switch self {
        case .getProfiles, .getRoomates:
            return .get
        case .addRoomate:
            return .post
        case .updateRoomateProfile:
            return .put
        case .deleteRoomate:
            return .delete
        }
    }
}
