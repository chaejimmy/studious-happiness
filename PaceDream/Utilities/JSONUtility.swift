////
//  JSONUtility.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class JSONUtility {
    static func getObject<T: Codable>(from data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            debugPrint(object: self, function: #function, error: error)
            return nil
        }
    }
    
    static func getData<T: Codable>(from object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(object)
            return data
        } catch {
            debugPrint(object: self, function: #function, error: error)
            return nil
        }
    }
}
