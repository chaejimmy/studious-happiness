//
//  Validator.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 17/05/2023.
//

import Foundation

class Validator: NSObject {
    @discardableResult func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.requireUsername }
        
        guard username.count > 0 else { throw ValidationError.requireUsername }
        
        let emailValidator = EmailValidator()
        guard emailValidator.isValidEmail(email: username) else { throw ValidationError.inValidEmail}
        
        return username
    }
    
    @discardableResult func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.requirePassword }
        
        guard password.count > 0 else { throw ValidationError.requirePassword }
        
        return password
    }
}

class EmailValidator: NSObject {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
}

enum ValidationError: LocalizedError {
    case requireUsername
    case requirePassword
    case inValidEmail
    
    var errorDescription: String? {
        switch self {
            case .requireUsername:
                return "Email address is required"
            case .requirePassword:
                return "Password is required"
            case .inValidEmail:
                return "Invalid email address"
        }
    }
}
