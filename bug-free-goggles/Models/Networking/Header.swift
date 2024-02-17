////
//  Header.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct Headers {
    var headers: [String: String] = [
        "content-type": "application/json"
    ]
    
    init(token: String? = nil) {
        if let token = token{
            headers["Authorization"] = "Bearer \(token)"
        }
    }
    
    mutating func addHeader(key: String, value: String) {
        headers[key] = value
    }
    
    mutating func setBearerToken(token: String) {
        addHeader(key: "Authorization", value: "Bearer \(token)")
    }
}
