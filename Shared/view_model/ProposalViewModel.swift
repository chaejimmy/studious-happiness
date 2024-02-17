//
//  ProposalViewModel.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 13/05/2023.
//



import SwiftUI

class ProposalViewModel: ObservableObject {
    
    static let shared = BasicSetUpViewModel()

    
    @Published var showPhotoPicker: Bool = false
    @Published var openChooserSheet: Bool = false
    @Published var isPickFromGallery: Bool = false
    
    @Published var isCheckInCalender: Bool = false

    @Published var isCheckOutCalender: Bool = false


    
    @Published var image: UIImage? = nil
    
    
    var imageGallery: [UIImage] = []


    
    func storeImage(image : UIImage) {
        imageGallery.append(image)
    }

    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var mobileNo: String = ""
    @Published var email: String = ""
    @Published var searchText: String = ""
    @Published var titleText: String = "House Ariena, United Kingdom"

    @Published var noteText: String = "You'll have a great time at this comfortable place to stay."


    @Published var selectedTime: TimeType = .day

    @Published var selectedPlaceType: PlaceType = .appartment
    
    @Published var selectedPlaces: [PlaceType] = []

    
    @Published var selectedAmentities: [Amentities] = []

    
    
    @Published var selectedStandardAmentities: [StandardAmentities] = []


    
    @Published var selectedRoom: RoommType = .single

    
    @Published var selectedPersonType: PersonType = .me

    
    

    
    @Published var currentView: Int = 0

    
    
    
 
    
    
    func goPreviousView() {
        if currentView != 0{
            currentView -= 1
            
        }
    }
    
    func goNextView() {
        if currentView != 8{
            currentView += 1
            
        }
    }
    
    
    func openImagePicker(isPickFromGallery: Bool = false) {
        self.isPickFromGallery = isPickFromGallery
        self.openChooserSheet = true
    }

}


enum TimeType: CaseIterable {
    case hour, day
    
    var title: String {
        switch self {
        case .hour: return "Hour"
        case .day: return "Day"
        }
    }
}

enum PlaceType: Identifiable, CaseIterable {
    case appartment, hotel, house, btn
    
    var id: UUID {
        UUID()
    }
    
    var data: RoomData {
        switch self {
        case .appartment: return RoomData(title: "Apartment", image: "apartment")
        case .hotel: return RoomData(title: "Hotel", image: "hotel")
        case .btn: return RoomData(title: "Button", image: "hotel")
        case .house: return RoomData(title: "House", image: "house")
        }
    }
}


enum RoommType: CaseIterable {
    case single, shared
    
    var data: RoomData {
        switch self {
        case .single: return RoomData(title:"Single room",image:"apartment")
        case .shared: return RoomData(title:"Shared Room",image:"shared")


        }
    }
}


enum PersonType: CaseIterable {
    case me, multiple
    
    var data: RoomData {
        switch self {
        case .me: return RoomData(title:"Only Me",image:"person")
        case .multiple: return RoomData(title:"Multiple Persons",image:"personplus")

        }
    }
}



let roomItems: [String] = ["Person", "Bedrooms", "Beds", "Bathrooms"]







enum Amentities: CaseIterable {
    case TV, Free, Wifi, Dedicated,Air,Washing
    
    var data: RoomData {
        switch self {
        case .TV: return RoomData(title:"TV",image:"tv")
        case .Free: return RoomData(title:"Free parking on premises",image:"car")
        case .Wifi: return RoomData(title:"Wifi",image:"wifi")
        case .Dedicated: return RoomData(title:"Dedicated workspace",image:"dedicated")
        case .Air: return RoomData(title:"Air Conditioning",image:"air")
        case .Washing: return RoomData(title:"Washing Machine",image:"dedicated")



        }
    }
}



enum StandardAmentities: CaseIterable {
    case equipment, Patio, grill, fireplace,tub,Pool,shower
    
    var data: RoomData {
        switch self {
        case .equipment: return RoomData(title:"Exercise equipment",image:"dedicated")
        case .Patio: return RoomData(title:"Patio",image:"patio")
        case .grill: return RoomData(title:"BBQ grill",image:"gril")
        case .fireplace: return RoomData(title:"Indoor fireplace",image:"dedicated")
        case .tub: return RoomData(title:"Hot tub",image:"tub")
        case .Pool: return RoomData(title:"Pool",image:"pool")
        case .shower: return RoomData(title:"Outdoor shower",image:"dedicated")



        }
    }
}






class RoomData :Identifiable {
    var title: String
    var image: String
    
    init(title: String, image: String) {
           self.title = title
           self.image = image
       }

}





