////
//  RoomLocationViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation
import SwiftUI
import MapKit

class RoomLocationViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
    @Published var locations = [Location(title: "Room Location", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275))]
    
    func setUpLocation(location: LocationData?){
        if let location = location {
            locations = [Location(title: "Room Location", coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude))]
        }
    }
}
