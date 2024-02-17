////
//  NetworkUtility.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class NetworkUtility {
    
    static let shared = NetworkUtility()
    
    private init() { }
    
    private let session = URLSession.shared
    
    private func prepareRequest(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        queryParams: [String: String]? = nil,
        body: Data? = nil
    ) throws -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if let queryParams = queryParams {
            urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = urlComponents?.url else {
            throw APIError(statusCode: -1, message: "Invalid URL: \(urlComponents?.url?.absoluteString ?? "")")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        print("CURL:- \(request.curlString)")
        return request
    }
    
    private func makeRequest(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError(statusCode: -1, message: "Invalid response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError(
                statusCode: httpResponse.statusCode,
                message: "Request failed with status code: \(httpResponse.statusCode)",
                responseData: data
            )
        }
        return (data, httpResponse)
    }
    
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError(
                statusCode: -1,
                message: "Failed to decode response",
                underlyingError: error,
                responseData: data
            )
        }
    }
    
    func request(
        endpoint: Endpoint,
        headers: Headers = Headers(),
        queryParams: [String: String]? = nil,
        body: Encodable? = nil
    ) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let url = try endpoint.url()
            var bodyData: Data? = nil
            if let body = body{
                let encoder = JSONEncoder()
                bodyData = try encoder.encode(body)
            }
            let request = try prepareRequest(url: url, method: endpoint.method, headers: headers.headers, queryParams: queryParams, body: bodyData)
            let (data, response) = try await makeRequest(request: request)
            return (data, response)
        } catch {
            if let apiError = error as? APIError {
                print(apiError.description)
            }
            throw error
        }
    }
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        headers: Headers = Headers(),
        queryParams: [String: String]? = nil,
        body: Encodable? = nil
    ) async throws -> T {
        let (data, _) = try await request(endpoint: endpoint, headers: headers, queryParams: queryParams, body: body)
        do {
            let object: T = try decode(data: data)
            return object
        } catch {
            if let apiError = error as? APIError {
                print(apiError.description)
            }
            throw error
        }
    }
}

extension URLRequest {
    var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H \"\(key): \(value)\"")
            }
        }

        if let bodyData = httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            command.append("-d '\(bodyString)'")
        }

        return command.joined(separator: " ")
    }
}
