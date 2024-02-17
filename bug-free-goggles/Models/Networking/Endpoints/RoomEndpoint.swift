////
//  RoomEndpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

/// Endpoints related to rooms
enum RoomEndpoint: String, EndpointProtocol {
    case addRoom = "/v1/add_room"
    case updateRoom = "/user/update_room"
    case getAllRooms = "/user/get_all_rooms"
    case deleteUserRoom = "user/perm_del_room"
    case getAllHosts = "/hotel"///host"
    
    /// The path of the endpoint
    var path: String {  return rawValue }
    
    /// The HTTP method associated with the endpoint.
    var method: HTTPMethod {
        switch self {
        case .getAllRooms:
            return .get
        case .addRoom:
            return .post
        case .updateRoom:
            return .put
        case .deleteUserRoom:
            return .delete
        case .getAllHosts:
            return .get
        }
    }
}
