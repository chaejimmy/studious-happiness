////
//  APIError.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct APIError: Error {
    let statusCode: Int
    let message: String
    let underlyingError: Error?
    let responseData: Data?
    
    init(statusCode: Int, message: String, underlyingError: Error? = nil, responseData: Data? = nil) {
        self.statusCode = statusCode
        self.message = message
        self.underlyingError = underlyingError
        self.responseData = responseData
    }
    
    var description: String {
        var errorDescription = "APIError - Status Code: \(statusCode)\n"
        errorDescription += "Message: \(message)\n"
        
        if let responseData = responseData,
           let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: []),
           let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
           let responseString = String(data: prettyPrintedData, encoding: .utf8) {
            errorDescription += "Response Data:\n\(responseString)\n"
        }
        
        if let underlyingError = underlyingError {
            errorDescription += "Underlying Error: \(underlyingError)\n"
        }
        
        return errorDescription
    }

    func getMessage() -> String? {
        if let data = responseData,
           let response: SuccessMessage = JSONUtility.getObject(from: data){
            return response.message
        }
        else{
            return message
        }
    }
    
    func getObject<T: Codable>() -> T?{
        guard let responseData = responseData else {
            return nil
        }
        let object:T? = JSONUtility.getObject(from: responseData)
        return object
    }
}

