//
//  BasicSetUpViewModel.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

class BasicSetUpViewModel: ObservableObject {
    
    static let shared = BasicSetUpViewModel()

    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var mobileNo: String = ""
    @Published var email: String = ""


    var nameContinueDisable: Bool {
        firstName.isEmpty || lastName.isEmpty
    }
    
    @Published var day: String = ""
    @Published var month: String = ""
    @Published var year: String = ""
    
    var dateContinueDisable: Bool {
        day.isEmpty || month.isEmpty || year.isEmpty
    }
    
    @Published var selectedGender: GenderType = .female
    
    @Published var image: UIImage? = nil
    
    @Published var selectedHobbies: [Hobbies] = []
    
    @Published var selectedTab: Int = 0
    
    
    @Published var showPhotoPicker: Bool = false
    @Published var openChooserSheet: Bool = false
    @Published var isPickFromGallery: Bool = false
    
    @Published var openMainView: Bool = false
    
    
    
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showBasicSetUp: Bool = false
    
    var passeordCheck: Bool {
        !password.isEmpty && password.count < 8
    }
    
    var confirmPasswordCheck: Bool {
       !confirmPassword.isEmpty && password != confirmPassword
    }
    
    var passwordContinueDisable: Bool {
        password.isEmpty || confirmPassword.isEmpty || passeordCheck || confirmPasswordCheck
    }

    
    func openImagePicker(isPickFromGallery: Bool = false) {
        self.isPickFromGallery = isPickFromGallery
        self.openChooserSheet = true
    }
    
    func navigateToMain() {
        openMainView = true
    }
}


enum GenderType: CaseIterable {
    case male, female, preferNotToSay
    
    var title: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .preferNotToSay: return "Prefer not to say"
        }
    }
}

enum Hobbies: CaseIterable {
    case cooking
    case learningLanguages
    case art
    case music
    case gym
    case photography
    case travel
    case swimming
    case playingGames
    case sports
    case dance
    
    var title: String {
        switch self {
        case .cooking: return "Cooking"
        case .learningLanguages: return "Learning Languages"
        case .music: return "Music"
        case .gym: return "Gym"
        case .photography: return "Photography"
        case .travel: return "Travel"
        case .art: return "Art"
        case .swimming: return "Swimming"
        case .playingGames: return "Playing Games"
        case .sports: return "Sports"
        case .dance: return "Dance"
        }
    }
}
