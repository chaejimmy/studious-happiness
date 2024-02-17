////
//  OnboardingViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI
import CountryPicker
import Combine

enum AuthFlowType {
    case signup
    case login
    case loginWithPhone
    case forget_password
    
    mutating func loginSignUpToggle() {
        if self == .signup {
            self = .login
        } else {
            self = .signup
        }
    }
}
 

class OnboardingViewModel: ObservableObject {
    
    static let shared = OnboardingViewModel()
    
    var userAuthService = UserAuthService()
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @Published var country: Country = CountryManager.shared.currentCountry ?? Country.init(countryCode: "US")
    var countryCode: String {
        country.dialingCode ?? "+1"
    }
    
    @Published var authFlowType: AuthFlowType = .login
    @Published var isEmailSelected = true
    
    @Published var isPasswordVisible = true
    
    @Published var mobileNo: String = ""
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var dob: String = ""
    
    @Published var showVerification: Bool = false
    @Published var openMainView: Bool = false
    
    @Published var isLoading = false
    var requests = Set<AnyCancellable>()
    
    var mobileValidation: Bool {
        mobileNo.isEmpty || mobileNo.count < 8 //|| emailValidation
    }
    
    var emailValidation: Bool {
        !Validator.isValidEmail(email)
    }
    
    var formValidation: Bool {
        (
            isEmailSelected ? emailValidation : mobileValidation
        )
        ||
        authFlowType == .login ? password.count < 8 : password.count < 7 || password != confirmPassword
    }
    
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showBasicSetUp: Bool = false
    
    @UserDefault("UserAuth", defaultValue: nil)
    var userAuth: UserAuthData?
    
    var passeordCheck: Bool {
        password.isNotEmpty && password.count < 8
    }
    
    var confirmPasswordCheck: Bool {
        confirmPassword.isNotEmpty && password != confirmPassword
    }
    var loginPasswordContinueDisable: Bool {
        password.isEmpty || passeordCheck
    }
    var passwordContinueDisable: Bool {
        password.isEmpty || confirmPassword.isEmpty || passeordCheck || confirmPasswordCheck
    }
    
    let totalTime: Int = 60
    let otpLength: Int = 6
    @Published var timer: Timer?
    
    @Published var timeElapsed: Int = 60
    @Published var otpText: String = ""
    
    @Published var showPasswordView: Bool = false
    
    private let authNetworkService = AuthNetworkService()
    
    var resendOtpEnable: Bool {
        timeElapsed == totalTime
    }
    
    var confirmOTPEnable: Bool {
        otpText.count == otpLength
    }
    
    func sendOTPAndTimerStart() {
        Task {
            await sendOPTAndStartTimerAsync()
        }
    }
    
    func sendOPTAndStartTimerAsync() async {
        let status = await sendOtpAsync(fromVerification: true)
        await MainActor.run(body: {
            if status{
                startTimer()
            }
            else{
                timerStop()
            }
        })
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            self.timeElapsed -= 1
            if self.timeElapsed == 0 {
                self.timerStop()
            }
        }
    }
    
    func timerStop() {
        self.timeElapsed = self.totalTime
        self.timer?.invalidate()
    }
    
    func navigateToMain() {
        openMainView = true
    }
    
    
}


extension OnboardingViewModel {
    func sendOtp(fromVerification: Bool = false) {
        Task {
            let success = await sendOtpAsync(fromVerification: fromVerification)
            await MainActor.run(body: {
                if success {
                    showVerification = true
                }
            })
        }
    }
    
    func sendOtpAsync(fromVerification: Bool = false) async -> Bool {
        await MainActor.run(body: {
            isLoading = true
        })
        let sendOtpRequest = SendOtpRequest(mobile: countryCode.appending(mobileNo))
        do {
            try await authNetworkService.sendOPT(sendOtpRequest: sendOtpRequest)
            await MainActor.run(body: {
                isLoading = false
            })
            return true
        }
        catch let error {
            await GlobalAlertController.showAlertAsync(title: "Alert", message: error.message)
        }
        await MainActor.run(body: {
            isLoading = false
        })
        return false
    }
    
    
    func verifyOtp() {
        Task {
            let success = await verifyOPTAsync()
            await MainActor.run(body: {
                if success {
                    self.showPasswordView = true
                }
            })
        }
    }
    
    func verifyOPTAsync() async -> Bool {
        await MainActor.run(body: {
            isLoading = true
        })
        let verifyOtpRequest = VerifyOtpRequest(mobile: countryCode.appending(mobileNo), otp: otpText)
        do {
            try await authNetworkService.verifyOTP(verifyOtpRequest: verifyOtpRequest)
            await MainActor.run(body: {
                isLoading = false
            })
            return true
        }
        catch let error {
            await GlobalAlertController.showAlertAsync(title: "Alert", message: error.message)
        }
        await MainActor.run(body: {
            isLoading = false
        })
        return false
    }
    
    
    func loginWithEmail() {
        Task {
            await loginWithEmailAsync()
        }
    }
    
    func loginWithPhone() {
        Task {
            await loginWithPhoneAsync()
        }
    }
    
    func loginWithEmailAsync() async {
        await MainActor.run(body: {
            isLoading = true
        })
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailLoginRequest = EmailLoginRequest(email: email, password: password)
        do {
            let response = try await authNetworkService.loginWithEmail(emailLoginRequest: emailLoginRequest)
//            let userAuthData = try response.getData()
            await MainActor.run {
                isLoading = false
                self.isLoggedIn = true
                OnboardingViewModel.shared.userAuth = response
//                @UserDefault("UserAuth", defaultValue: OnboardingViewModel.shared.userAuth)
                 _ = UserDefault("UserAuth", defaultValue: OnboardingViewModel.shared.userAuth)
                let userInfo = UserDefaultsCodable<UserAuthData>.init(key: "UserAuth").getObject()
                print("UserInfo_____: \(userInfo.debugDescription)")
                //self.navigateToMain()
            }
        }
        catch let error {
            await MainActor.run {
                isLoading = false
                var message = error.localizedDescription
                if let apiError = error as? APIError {
                    message = apiError.message
                }
                GlobalAlertController.showAlert(title: "Alert", message: message)
            }
        }
    }
    
    func loginWithPhoneAsync() async {
        await MainActor.run(body: {
            isLoading = true
        })
        let mobile = countryCode.appending(OnboardingViewModel.shared.mobileNo)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneLoginRequest = PhoneLoginRequest(mobile: mobile)
        do {
            let response = try await authNetworkService.loginWithPhone(phoneLoginRequest: phoneLoginRequest)
            let userAuthData = try response.getData()
            await MainActor.run {
                isLoading = false
                self.isLoggedIn = true
                OnboardingViewModel.shared.userAuth = userAuthData
                //self.navigateToMain()
            }
        }
        catch let error {
            await MainActor.run {
                isLoading = false
                var message = error.localizedDescription
                if let apiError = error as? APIError {
                    message = apiError.message
                }
                GlobalAlertController.showAlert(title: "Alert", message: message)
            }
        }
    }
}

