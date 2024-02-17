////
//  Decode+Date.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeDate(forKey key: K, format: Date.Format = .iso8601) throws -> Date {
        let dateString = try decode(String.self, forKey: key)
        guard let date = Date.fromString(dateString, format: format) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Invalid date format")
        }
        return date
    }
    
    func decodeDateIfPresent(forKey key: K, format: Date.Format = .iso8601) throws -> Date? {
        let dateString = try decodeIfPresent(String.self, forKey: key)
        guard let dateString = dateString, let date = Date.fromString(dateString, format: format) else {
            return nil
        }
        return date
    }
}
