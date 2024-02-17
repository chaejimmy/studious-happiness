//
//  APIServices.swift
//  PaceDream
//
//  Created by Vipin Saini on 06-01-2024.
//

import Foundation
import Alamofire

class APIServices: NSObject {
    
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var url: String! = BASE_URL
    var encoding: ParameterEncoding! = JSONEncoding.default
    var isTokenReq = true
    var showLoader = true
    
    // MARK: - Init
    
    init(data: [String: Any],
         headers: [String: String] = [:],
         endPoint: Services? = nil,
         queryPath: String? = "",
         method: HTTPMethod = .post,
         isJSONRequest: Bool = true,
         isShowLoader: Bool = true) {
        
        super.init()
        
        if isShowLoader == false {
            showLoader = false
        }

    #warning ("please add internet config")
        userDefaults.isInternetConnected = true
        
        data.forEach {parameters.updateValue($0.value, forKey: $0.key)}
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        
       
        
        if endPoint != nil {
            self.url += endPoint!.rawValue
            if let path = queryPath, path.isEmpty == false {
                    self.url += "/\(path)"
             
            }
        }
        
        let auth = userDefaults.authToken
        if !auth.isEmpty, isTokenReq {
            self.headers.add(HTTPHeader(name: "x-auth-token", value: auth))
        }
        
        let pushToken = userDefaults.firebaseToken
        
        if !pushToken.isEmpty {
            self.headers.add(HTTPHeader(name: "x-push-token", value: pushToken))
        }
        
        if !isJSONRequest {
            encoding = URLEncoding.default
        }
        self.method = method
        print("\n\n-------\n Service: \(endPoint?.rawValue ?? self.url ?? "") \n data: \(parameters)")
    }
    
    
    // MARK: - Execute Query
    
    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if !userDefaults.isInternetConnected {
            helper.hideLoader()
            //            helper.showToast(message: "Please check your network connection.", title: "Oops!, No Internet")
            let customError = NSError(domain: "PaceDream", code: 0, userInfo: [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
            completion(.failure(customError))
            return
        }
        if showLoader {
            helper.showLoader()
        }
        AF.sessionConfiguration.timeoutIntervalForRequest = 60
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData(completionHandler: {response in
            helper.hideLoader()
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...504:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print("\n\n---Error----\n", String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                        print("\n\n---Error----\n", String(data: res, encoding: .utf8) ?? "nothing received")
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("\n\n---Error----\n", error.errorDescription ?? "nothing received")
                completion(.failure(error))
            }
        }).cURLDescription { description in
            print("API_cURL_POST_RequestParam:--- \(description)\n_____________________")
        }
    }
    
    
    func getQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if !userDefaults.isInternetConnected {
            helper.hideLoader()
            //            helper.showToast(message: "Please check your network connection.", title: "Oops!, No Internet")
            let customError = NSError(domain: "PaceDream", code: 0, userInfo: [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
            completion(.failure(customError))
            return
        }
        
        if showLoader {
            helper.showLoader()
        }
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 30 // 30 secont
        
        let request = self.setRequestUrl(requestType: "GET", url: self.url)
        AF.request(request as URLRequestConvertible).responseData(completionHandler: {response in
            helper.hideLoader()
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...504:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print("\n\n---Error----\n", String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                        print("\n\n---Error----\n", String(data: res, encoding: .utf8) ?? "nothing received")
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("\n\n---Error----\n", error.errorDescription ?? "nothing received")
                completion(.failure(error))
            }
        }).cURLDescription { description in
            print("API_cURL_GET_RequestParam:--- \(description)\n_____________________")
        }
    }
    
    func setRequestUrl(requestType: String, url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = requestType
        request.headers = setHeader()
        return request
    }
    
    func setHeader() -> HTTPHeaders {
        let auth = userDefaults.authToken
        let pushToken = userDefaults.firebaseToken
        
        if !auth.isEmpty, isTokenReq {
            
            
            if !pushToken.isEmpty {
                let headers: HTTPHeaders = ["Content-Type": "application/json",
                                            "x-auth-token": auth,
                                            "x-push-token": pushToken]
                return headers
            } else {
                let headers: HTTPHeaders = ["Content-Type": "application/json",
                                            "x-auth-token": auth]
                return headers
            }
        } else if !pushToken.isEmpty {
            let headers: HTTPHeaders = ["Content-Type": "application/json",
                                        "x-push-token": pushToken]
            return headers
        } else {
            let headers: HTTPHeaders = ["Content-Type": "application/json"]
            return headers
        }
    }
}
