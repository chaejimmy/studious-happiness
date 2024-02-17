////
//  RoomNetworkService.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class RoomNetworkService{
    func getAllRooms() async -> [RoomData] {
        let endpoint = Endpoint(RoomEndpoint.getAllRooms)
        do {
            let response: Response<[RoomData]> = try await NetworkUtility.shared.request(endpoint: endpoint)
            let rooms = response.data ?? []
            print("*****","Rooms response fetched.")
            return rooms
        } catch let error {
            print(error)
        }
        return []
    }
    
    func getAllHosts() async -> [HostData] {
        let endpoint = Endpoint(RoomEndpoint.getAllHosts)
        do {
            let response: Response<[HostData]> = try await NetworkUtility.shared.request(endpoint: endpoint)
            let hosts = response.data ?? []
            print("*****","Hosts response fetched.")
            return hosts
        } catch let error {
            print(error)
        }
        return []
    }
}

