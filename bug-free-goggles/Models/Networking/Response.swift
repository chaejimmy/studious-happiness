////
//  Response.swift
//  bug-free-goggles
//
//  Created by Mac on 16/05/23.
//

import Foundation

//struct Response<T: Codable>: Codable {
//    let status: Bool
//    let code: Int
//    let message: ResponseMessage
//    var data: T?
//    
//    private enum CodingKeys: String, CodingKey {
//        case status, code, message, data
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decode(Bool.self, forKey: .status)
//        code = try values.decode(Int.self, forKey: .code)
//        message = try values.decode(ResponseMessage.self, forKey: .message)
//        data = try? values.decode(T.self, forKey: .data)
//    }
//    
//    func getData() throws -> T?{
//        guard code == 200 else {
//            let errorMessage = message.errorMsg?.errors ?? GlobalAlertController.errorMessage
//            throw APIError(statusCode: code, message: errorMessage)
//        }
//        return data
//    }
//    
//    func getObject() throws -> T{
//        if code != 200, let errorMessage = message.errorMsg?.errors {
//            throw APIError(statusCode: code, message: errorMessage)
//        }
//        guard let data = data else{
//            throw APIError(statusCode: code, message: "Invalid data")
//        }
//        return data
//    }
//}
//


struct Response<T: Codable>: Codable {
    let action: String
    let code: Int
    let status: Bool
    var data: T?
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case action, code, status, data, message
    }

    func getData() throws -> T? {
        guard code == 200 else {
            throw APIError(statusCode: code, message: message)
        }
        return data
    }

    func getObject() throws -> T {
        if code != 200 {
            throw APIError(statusCode: code, message: message)
        }
        guard let data = data else {
            throw APIError(statusCode: code, message: "Invalid data")
        }
        return data
    }
}
