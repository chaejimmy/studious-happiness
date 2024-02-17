////
//  RoomLocationView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}

struct RoomLocationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = RoomLocationViewModel()
    let location: LocationData?
    
    var body: some View {
        VStack(spacing: 8) {
            CustomNavBar(title: "Room Location"){
                dismiss()
            }

            Map(coordinateRegion: $vm.region, annotationItems: vm.locations) {
                MapAnnotation(coordinate: $0.coordinate) {
                    Image("locationIcon")
                        .resizable()
                        .frame(width: 48, height: 48)
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear{
            vm.setUpLocation(location: location)
        }
    }
}

struct RoomLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RoomLocationView(location: PreviewData.locationData)
    }
}
