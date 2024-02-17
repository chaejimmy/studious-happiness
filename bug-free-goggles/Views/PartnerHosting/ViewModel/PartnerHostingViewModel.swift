////
//  PartnerHostingViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import Foundation
import SwiftUI
@MainActor
class PartnerHostingViewModel: ObservableObject {
    
    @Published var navigateToAddressDescibe: Bool = false
    @Published var navigateToAboutInterests: Bool = false
    @Published var navigateToUploadImages: Bool = false
    @Published var navigateToGiveATitle: Bool = false
    @Published var navigateToPricingLimit: Bool = false
    @Published var navigateToGiveAvailability: Bool = false
    
    //Address Places
    @Published var places: [String] = []
    
    
    // Address Describe
    @Published var guestCount: Int = 2
    @Published var selectedGender: GenderType? = nil
    @Published var selectedPets: PetsSelectionType? = nil
    var addressDescribeValidation: Bool {
        selectedGender == nil || selectedPets == nil
    }
    
    //About Interests
    @Published var selectedHobbies: [Hobbies] = []
    var aboutInterestsValidation: Bool {
        selectedHobbies.isEmpty
    }
    
    //Image Upload
    @Published var selectedImages = [Image]()
    var uploadImageValidation: Bool {
        selectedImages.count < 4
    }
    
    //GiveATitle
    @Published var heading: String = ""
    @Published var note: String = ""
    var giveATitleValidation: Bool {
        heading.isEmpty || note.isEmpty
    }
    
    //GiveAvailability
    @Published var picker: DayHourPickerView.Picker = .day
    //hour
    @Published var date: Date = Date()
    @Published var checkInTime: Date = Date()
    @Published var checkOutTime: Date = Date().addingTimeInterval(3600)
    //Day
    @Published var checkInDate: Date = Date()
    @Published var checkOutDate: Date = Date().addingTimeInterval(24*3600)
}
