////
//  Error+APIError+Message.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

extension Error{
    var message: String {
        var message = localizedDescription
        if let apiError = self as? APIError,
            let msg = apiError.getMessage() {
            message = msg
        }
        return message
    }
}
