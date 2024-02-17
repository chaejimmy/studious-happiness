//
//  MapView.swift
//  bug-free-goggles
//
//  Created by Viswanath Reddy on 06/05/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel: MapViewModel
    @Binding var enlargeMapView:Bool
    @Binding var region: MKCoordinateRegion
    
    var height: CGFloat = 450
    // MARK: - BODY
    var body: some View {
        //Ref: https://developer.apple.com/forums/thread/719701
        let binding = Binding(
            get: { self.region },
            set: { newValue in
                DispatchQueue.main.async {
                    self.region = newValue
                }
            }
        )
        
        Map(
            coordinateRegion: binding,
            showsUserLocation: true,
            annotationItems: viewModel.annotationItems,
            annotationContent: { location in
                MapAnnotation(
                    coordinate: location.coordinate,
                    content: {
                        AddressAnnotationView(title: location.title)
                    }
                )
            }
        )
        .frame(minHeight: enlargeMapView ? getScreenBounds().height-150 : height)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            HStack (spacing: 2) {
                Spacer()
                
                Button {
                    viewModel.zoomOut()
                } label: {
                    Image("zoomout")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 0.1)
                }
                
                Button {
                    viewModel.zoomIn()
                } label: {
                    Image("zoomin")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 0.1)
                }
                
            }.padding([.trailing, .bottom], 20)
            ,alignment: .bottomTrailing
        )
        .overlay(
            Button {
                enlargeMapView.toggle()
            } label: {
                Image("enlarge")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 0.1)
            }.padding([.trailing, .top], 20)
            
            , alignment: .topTrailing
        ).zIndex(1)
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        let locationManager = LocationManager()
        MapView(viewModel: MapViewModel(location:locationManager), enlargeMapView: .constant(true), region: .constant(region))
    }
}
