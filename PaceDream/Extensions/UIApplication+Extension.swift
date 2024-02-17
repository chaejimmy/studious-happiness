////
//  UIApplication+Extension.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import SwiftUI

extension UIApplication {
    static var clientId: String? {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plistData = FileManager.default.contents(atPath: path) else { return nil }
        
        do {
            let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: nil) as? [String: Any]
            
            if let clientID = plistDictionary?["CLIENT_ID"] as? String {
                return clientID
            }
            
        } catch {
            print("Error reading plist: \(error)")
        }
        return nil
    }
  
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
