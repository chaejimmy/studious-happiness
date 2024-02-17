////
//  BookingNetworkService.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class BookingNetworkService{
    func getAllBookings() async -> [BookingData] {
        let endpoint = Endpoint(BookingEndpoint.getAllBookings)
        do {
            let response: Response<[BookingData]> = try await NetworkUtility.shared.request(endpoint: endpoint)
            let bookings = response.data ?? []
            print("*****","Bookings response fetched.")
            return bookings
        } catch let error {
            print(error)
        }
        return []
    }
}
