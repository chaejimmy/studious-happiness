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
    @Published var password: String = ""
    
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
        return date.string(.yyyyMMdd)
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
    func signUpWithEmail() {
          password = OnboardingViewModel.shared.password.trimmingCharacters(in: .whitespacesAndNewlines)
          email = OnboardingViewModel.shared.email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let body: [String: Any] = ["email": email,
                                   "firstName" : firstName,
                                   "lastName": lastName,
                                   "password": password,
                                   "dob": birthDate,
                                   "method": "email"]
      
        
        APIServices(data: body, endPoint: .signUp, method: .post).executeQuery() { (result: Result<SignUpEmailData, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    print("\n-------\n result:", result)
                    if result.status == true {
                        helper.showToast(message: "Register success!")
                        OnboardingViewModel.shared.userAuth = UserAuthData.init(action: result.action, code: result.code, status: result.status, data: UserInfoData(token: result.data?.token, firstName: result.data?.first_name, lastName: result.data?.last_name, userID: result.data?.user_id, roleID: result.data?.role_id), message: "")
                        
        //                @UserDefault("UserAuth", defaultValue: OnboardingViewModel.shared.userAuth)
                         _ = UserDefault("UserAuth", defaultValue: OnboardingViewModel.shared.userAuth)
                        let userInfo = UserDefaultsCodable<UserAuthData>.init(key: "UserAuth").getObject()
                        print("UserInfo_____: \(userInfo.debugDescription)")
                        self.isLoggedIn = true
                    } else {
                        helper.showToast(message: result.data?.error ?? "Something went wrong")
                    }
                    
                case .failure(let error):
                    print("\n-------\n Error: ", error)
                    let errorString = error.localizedDescription.replacingOccurrences(of: "URLSessionTask failed with error: ", with: "")
                    helper.showToast(message: errorString)
                }
            }
        }
    }
    
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
