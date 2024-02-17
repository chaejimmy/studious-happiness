////
//  Endpoint.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

struct Endpoint{
    //static let baseURL = "https://totel-backend.onrender.com/v1"
    //static let baseURL = "http://127.0.0.1:5001/v1"
    static let baseURL = "https://utotel.herokuapp.com/v1"
    //static let baseURL = "https://jimmy-dev-api-e2f1076467da.herokuapp.com/v1"
//    static let baseURL = "https://totel-backend.up.railway.app/v1"
    
    private let endpoint: EndpointProtocol
    
    init(_ endpoint: EndpointProtocol) {
        self.endpoint = endpoint
    }
    
    var method: HTTPMethod{
        return endpoint.method
    }
    
    func url() throws -> URL{
        guard let baseURL = URL(string: Endpoint.baseURL) else {
            throw APIError(statusCode: -1, message: "Invalid URL: \(Endpoint.baseURL)")
        }
        let finalURL = baseURL.appendingPathComponent(endpoint.path)
        
        return finalURL
    }
    
}
