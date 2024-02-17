////
//  Strings.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import Foundation

extension String {
    struct Hosting {
        static let placeSelectionTitle = "Where's your place located?"
        static let placeSelectionSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        static let enterLocation = "Enter location"
        static let next = "Next"
        static let back = "Back"
        static let describeAddressTitle = "Which of these best describes your place?"
        static let describeAddressSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        
        static let whoWillshareTheRoomTitle = "Who will share the room?"
        static let whoWillshareTheRoomSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        static let sharableDetails = "Sharable Details"
        static let persons = "Persons"
        static let bedrooms = "Bedrooms"
        static let beds = "Beds"
        static let bathrooms = "Bathrooms"
        
        static let amentiesInputPageTitle = "What are the amenities that place have have?"
        static let amentiesInputPageSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        static let uploadImagePageTitle = "Upload Images"
        static let uploadImagePageSubTitle = "Choose at least 6 pictures."
        static let addImages = "Add Images"
        static let browseFiles = "Browse Files"
        static let fromGallery = "from gallery"
        static let giveATitlePageTitle = "Let's give a title"
        static let giveATitlePageSubTitle = "Short titles work best. Have fun with it – you can always change it later."
        static let giveYourPricePageTitle = "Give your pricing"
        static let giveYourPricePageSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        static let giveYourAvailabilityPageTitle = "Give your availability"
        static let giveYourAvailabilityPageSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        static let hour = "Hour"
        static let day = "Day"
    }
    
    struct Constants {
        static let placeSelectionTitle = "Where're you planning to stay?"
        static let placeSelectionSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        
        static let enterPlaces = "enter places"
        
        static let partnerDetailTitle = "Who can stay with you?"
        static let guests = "Guests"
        static let pets = "Pets"
        static let tellAboutInterests = "Tell about your interests!"
        
        static let uploadAtleastFourImage = "Choose at least 4 pictures."
        static let uploadAtleastSixImage = "Choose at least 6 pictures."
        static let fromGalleryCameraText = " from gallery or camera"
        static let fromGalleryText = " from gallery"
        static let givePricingLimitTitle = "Give your pricing limit"
        static let givePricingLimitSubTitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
    }
}

extension String{
    struct Proposal{
        static let shared = Proposal()
        
        struct Availibility{
            let title = "Give your availability"
            let subtitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        }
        let availibility = Availibility()
        
        struct Pricing {
            let title = "Give your pricing"
            let subtitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        }
        let pricing = Pricing()
        
        struct RoomDescription{
            let title = "Which of these best describes your booked room?"
            let subtitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        }
        let roomDescription = RoomDescription()
        
        struct Place {
            let title = "Where's your place located?"
            let subtitle = "In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room."
        }
        let place = Place()
    }
    
    static var proposal: Proposal{
        return .shared
    }
}
