////
//  UserDefaultsCodable.swift
//  bug-free-goggles
//
//  Created by Mac on 22/05/23.
//

import Foundation
import Combine

struct UserDefaultsCodable<T: Codable> {
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    // Save a Codable object to User Defaults
    func saveObject(object: T) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(object)
            UserDefaults.standard.set(encodedData, forKey: key)
        }
        catch let parseError {
            debugPrint(object: self, function: #function, error: parseError)
        }
    }
    
    // Retrieve a Codable object from User Defaults
    func getObject() -> T? {
        guard let encodedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: encodedData)
            return object
        }
        catch let parseError {
            debugPrint(object: self, function: #function, error: parseError)
        }
        return nil
    }
    
    // Remove the Codable object from User Defaults
    func removeObject() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    private let codable: UserDefaultsCodable<T>
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self.codable = UserDefaultsCodable(key: key)
    }
    
    var wrappedValue: T {
        get {
            guard let value = codable.getObject() else {
                return defaultValue
            }
            return value
        }
        set {
            codable.saveObject(object: newValue)
        }
    }
}
