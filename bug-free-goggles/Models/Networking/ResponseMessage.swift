////
//  ResponseMessage.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct ResponseMessage: Codable {
    let successMsg: String
    let errorMsg: ErrorMessage?

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()

        do {
            successMsg = try container.decode(String.self)
            errorMsg = nil
        } catch {
            successMsg = ""
            errorMsg = try container.decode(ErrorMessage.self)
        }
    }
    
    
    struct ErrorMessage: Codable {
        let errors: String
    }
}
