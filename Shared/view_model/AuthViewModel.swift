//
//  AuthViewModel.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

class AuthiewModel: ObservableObject {
    
    static let shared = AuthiewModel()
    

    @Published var mobileNo: String = ""
    @Published var showVerification: Bool = false
    
    var mobileValidation: Bool {
        mobileNo.isEmpty
    }
    
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
    
    let totalTime: Int = 60
    let otpLength: Int = 6
    @Published var timer: Timer?

    @Published var timeElapsed: Int = 60
    @Published var otpText: String = ""
    
    @Published var showPasswordView: Bool = false
    
    var resendOtpEnable: Bool {
        timeElapsed == totalTime
    }
    
    var confirmOTPEnable: Bool {
        otpText.count == otpLength
    }
    
    func sendOTPAndTimerStart() {
           timer = Timer.scheduledTimer(withTimeInterval: 1,
                                            repeats: true) { _ in
               self.timeElapsed -= 1
               if self.timeElapsed == 0 {
                   self.timeElapsed = self.totalTime
                   self.timer?.invalidate()
               }
           }
       }
    
    
    @Published var user: User = User(id: 0, name: "", email: "", token: "", isLogged: false)
       
       func login() {
           LoginApi().login(number:mobileNo, completion: { result, data in
               if result == .success {
                   guard let data = data else { return }
                   let decodedResponse = try! JSONDecoder().decode(UserApiData.self, from: data as! Data)
                   print(decodedResponse)
                   
                   DispatchQueue.main.sync {
                       if decodedResponse.login {
                           if let u = decodedResponse.data {
                               self.user = User(id: u.id, name: u.name, email: u.email, token: decodedResponse.token!, isLogged: true, message: decodedResponse.message)
                           }
                       } else {
                           self.user = User(id: 0, name: "", email: "", token: "", isLogged: false, message: decodedResponse.message)
                       }
                   }
               }
               
               if result == .error {
                   DispatchQueue.main.sync {
                       self.user = User(id: 0, name: "", email: "", token: "", isLogged: false)
                   }
               }
           })
       }
    
}
