//
//  DBManager.swift
//  PaceDream
//
//  Created by Vipin Saini on 06-01-2024.
//

import Foundation
 
class DBManager: NSObject {
    
    static let sharedInstance = DBManager()
    
    private override init() {
        
    }
}

let dbManager = DBManager.sharedInstance
 

extension DBManager {
    
    func removeUserInfo() {
        let dictionary = userDefaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            if key != "hasOnboarded" && key != "isInternetConnected" && key != "firebaseToken" {
                print("Remove Key:- ", key as Any)
                userDefaults.removeObject(forKey: key)
            }
        }
    }
}
