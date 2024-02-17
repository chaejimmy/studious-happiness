//
//  UserDefaults+Extension.swift
//  PaceDream
//
//  Created by Vipin Saini on 06-01-2024.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case hasOnboarded
        case isLogin
        case authToken
        case userInfo
        case firebaseToken
        case isInternetConnected
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
     
    var firebaseToken: String {
        get {
            string(forKey: UserDefaultsKeys.firebaseToken.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.firebaseToken.rawValue)
        }
    }
    
    var isLogin: Bool {
        get {
            bool(forKey: UserDefaultsKeys.isLogin.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.isLogin.rawValue)
        }
    }
  
    var authToken: String {
        get {
            string(forKey: UserDefaultsKeys.authToken.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.authToken.rawValue)
        }
    }
    
    var userInfo: [String: Any] {
        get {
            object(forKey: UserDefaultsKeys.userInfo.rawValue) as? [String: Any] ?? [:]
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.userInfo.rawValue)
        }
    }
      
    var isInternetConnected: Bool {
        get {
            bool(forKey: UserDefaultsKeys.isInternetConnected.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.isInternetConnected.rawValue)
        }
    }
}

let userDefaults = UserDefaults.standard
