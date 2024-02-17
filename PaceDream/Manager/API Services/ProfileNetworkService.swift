////
//  ProfileNetworkService.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class ProfileNetworkService{
    func getAllRoomMates() async -> [RoommateData] {
        let endpoint = Endpoint(ProfileEndpoint.getProfiles)
        do {
            let response: Response<[RoommateData]> = try await NetworkUtility.shared.request(endpoint: endpoint)
            let roomMates = response.data ?? []
            print("*****","RoomMates response fetched.")
            return roomMates
        } catch let error {
            print("error- \(error)")
        }
        return []
    }
}
