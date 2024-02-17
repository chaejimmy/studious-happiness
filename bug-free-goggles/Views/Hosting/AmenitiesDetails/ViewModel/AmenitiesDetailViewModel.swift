////
//  AmenitiesDetailViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import Foundation

protocol AmentiesMenuProtocol: MenuItemProtocol {
    func updateStandardAmentieSelected(selecteMenuItem: MenuItem)
    func resetStandardAmentieSelection()
    func isStandardAmetieSelected() -> Bool
}

class AmenitiesDetailViewModel: ObservableObject, AmentiesMenuProtocol {
    
    @Published var amenities : [MenuItem] = [
        MenuItem(title: "TV", imageName: "tv"),
        MenuItem(title: "Free parking on premises", imageName: "freeparking"),
        MenuItem(title: "Wifi", imageName: "wifi"),
        MenuItem(title: "Dedicated workspace", imageName: "placeholder"),
        MenuItem(title: "Air Conditioning", imageName: "airconditioning"),
        MenuItem(title: "Washing Machine", imageName: "placeholder"),
        
    ]
    
    @Published var standardAmenities : [MenuItem] = [
        MenuItem(title: "Exercise equipment", imageName: "placeholder"),
        MenuItem(title: "Patio", imageName: "patio"),
        MenuItem(title: "BBQ grill", imageName: "bbqgrill"),
        MenuItem(title: "Indoor fireplace", imageName: "placeholder"),
        MenuItem(title: "Hot tub", imageName: "hottub"),
        MenuItem(title: "Fire fit", imageName: "placeholder"),
        MenuItem(title: "Pool", imageName: "pool"),
        MenuItem(title: "Outdoor shower", imageName: "placeholder"),
       
    ]
    @Published var selectedAmenities: Set<Amenity> = []
    @Published var selectedStandardAmenities: Set<Amenity> = []
    
    
    func updateSelected(selecteMenuItem: MenuItem)  {
        if let idx = amenities.firstIndex(where: {$0.id == selecteMenuItem.id}){
            amenities[idx].isselected.toggle()
        }
    }
    
    func resetSelection(){
        for i in 0..<amenities.count {
            amenities[i].isselected = false
        }
    }
    
    func isSelected() -> Bool {
        amenities.filter({$0.isselected == true}).count > 0
    }
    
    func updateStandardAmentieSelected(selecteMenuItem: MenuItem) {
        if let idx = standardAmenities.firstIndex(where: {$0.id == selecteMenuItem.id}){
            standardAmenities[idx].isselected.toggle()
        }
    }
    
    func resetStandardAmentieSelection() {
        for i in 0..<standardAmenities.count {
            standardAmenities[i].isselected = false
        }
    }
    
    func isStandardAmetieSelected() -> Bool {
        standardAmenities.filter({$0.isselected == true}).count > 0
    }
    
}
