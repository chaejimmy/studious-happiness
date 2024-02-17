////
//  BasicSetUpViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 02/05/23.
//

import SwiftUI
import Combine

class BasicSetUpViewModel: ObservableObject {
    
    static let shared = BasicSetUpViewModel()
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var mobileNo: String = ""
    @Published var email: String = ""
    
    @Published var showLoader = false
    @Published var showMessageAlert = false
    @Published var goToRoot = false
    
    
    @Published var isLoading: Bool = false
    
    var nameContinueDisable: Bool {
        firstName.isEmpty || lastName.isEmpty || fNameCheck || lNameCheck
    }
    
    var fNameCheck: Bool {
        firstName.isNotEmpty && firstName.count < 3
    }
    
    var lNameCheck: Bool {
        lastName.isNotEmpty && lastName.count < 3
    }
    
    @Published var date: Date = Date()
    
    var requests = Set<AnyCancellable>()
    
    var dateContinueDisable: Bool {
        day.isEmpty || month.isEmpty || year.isEmpty
    }
    
    let calendar = Calendar.current
    
    var year: String {
        let components = calendar.dateComponents([ .year], from: date)
        return  "\(components.year ?? 0)"
    }
    
    var month: String {
        let components = calendar.dateComponents([ .month], from: date)
        return  "\(components.month ?? 0)"
    }
    
    var day: String {
        return "\(date.day)"
    }
  
    var birthDate: String {
        return date.string(.ddMMyyyydashed)
    }
    @Published var showDatePickerSheet: Bool = false
    
    @Published var selectedGender: GenderType = .female
    
    @Published var image: UIImage? = nil
    
    @Published var selectedHobbies: [Hobbies] = []
    
    @Published var selectedTab: Int = 0
    
    
    @Published var showPhotoPicker: Bool = false
    @Published var openMainView: Bool = false
    private let authNetworkService = AuthNetworkService()
    
    func navigateToMain() {
        openMainView = true
    }
    
}

extension BasicSetUpViewModel {
    func signUpWithPhone() {
        Task {
            await signUpWithPhoneAsync()
        }
    }
    
    private func signUpWithPhoneAsync() async {
        await MainActor.run(body: {
            isLoading = true
        })
        let mobile = OnboardingViewModel.shared.countryCode.appending(OnboardingViewModel.shared.mobileNo)
        let password = OnboardingViewModel.shared.password.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = OnboardingViewModel.shared.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneSignUpRequest = PhoneSignUpRequest(
            method: OnboardingViewModel.shared.isEmailSelected ? "custom_email": "custom_phone",
            mobile: mobile,
            email: email,
            firstName: firstName,
            lastName: lastName,
            password: password,
            birthDate: birthDate,
            gender: selectedGender.title
        )
        do {
            let response = try await authNetworkService.signUpWithPhone(phoneSignUpRequest: phoneSignUpRequest)
            let userAuthData = try response.getData()
            await MainActor.run {
                isLoading = false
                self.isLoggedIn = true
                OnboardingViewModel.shared.userAuth = userAuthData
                self.navigateToMain()
            }
        }
        catch let error {
            await MainActor.run {
                isLoading = false
            }
            await GlobalAlertController.showAlertAsync(title: "Alert", message: error.message)
        }
    }
}
