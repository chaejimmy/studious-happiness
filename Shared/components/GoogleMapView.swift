//
//  GoogleMapView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 14/05/2023.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    let mapView = GMSMapView()

    func makeUIView(context: Context) -> GMSMapView {

        mapView.settings.zoomGestures = true

        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 12)
                mapView.camera = camera
                

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the map view as needed
        // For example, set the map type, camera position, markers, etc.
    }
}
