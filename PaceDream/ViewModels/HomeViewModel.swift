////
//  HomeViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    @Published var searchText: String = ""
    
    @Published var selectedBookedType: BookedType = .hourlyRoom  //{
//        didSet {
//            selectedIndex = selectedBookedType.rawValue
//        }
//    }
//    @Published var selectedIndex: Int = 0
    @Published var openFilterSheet: Bool = false
    var requests = Set<AnyCancellable>()
    
    @Published var allBookings: [BookingData] = []
    @Published var allRooms: [RoomData] = []
    @Published var allHosts: [HostData] = []
    @Published var allRoomMates: [RoommateData] = []
    @Published var isLoading: Bool = false
    private let bookingNetworkService = BookingNetworkService()
    private let roomNetworkService = RoomNetworkService()
    private let profileNetworkService = ProfileNetworkService()
    
    init() {
        Task {
            await fetchAsync()
        }
    }
    
    func fetchAsync() async {
        await MainActor.run(body: {
            isLoading = true
        })
        
        async let allBookingAsync = bookingNetworkService.getAllBookings()
        async let allRoomsAync = roomNetworkService.getAllRooms()
        async let allRoomMatesAync = profileNetworkService.getAllRoomMates()
        async let allHostsAync = roomNetworkService.getAllHosts()
        
        let (rooms, bookings, hosts) = await (allRoomsAync, allBookingAsync, allHostsAync)
        await MainActor.run(body: {
            allRooms = rooms
            allBookings = bookings
//            allRoomMates = roommates
            allHosts = hosts
            setUpBookingData()
            setUpPartnerData()
            isLoading = false
        })
    }
    
    func setUpBookingData() {
        for i in allBookings.indices {
            if let roomData = allRooms.first(where: { $0.id == allBookings[i].room }) {
                allBookings[i].roomData = roomData
            }
            if let roomMateData = allRoomMates.first(where: { $0.user == allBookings[i].user }) {
                allBookings[i].roomMateData = roomMateData
            }
        }
    }
    
    func setUpPartnerData() {
        for i in allRoomMates.indices {
            if let roomData = allRooms.first(where: { $0.id == allRoomMates[i].room }) {
                allRoomMates[i].roomData = roomData
            }
        }
    }
}
