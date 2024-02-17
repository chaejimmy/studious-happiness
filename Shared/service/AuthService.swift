//
//  AuthService.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 16/05/2023.
//

import Foundation

enum ResponseResult {
    case success
    case error
}

final class LoginApi {
    
    func login(number: String, completion: @escaping (_ result: ResponseResult, _ data: Any?) -> ()) {
        

        
        
        let postData = "method=custom_phone&mobile=%2B\(number)&first_name=John&last_name=doe&password=12345678&date_of_birth=12-10-1990&gender=Male".data(using: .utf8)
        
        
          
        guard let url = URL(string: AppSettings.HOST + "/auth/signup") else { return }
       
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            
            if let postDataString = String(data: data, encoding: .utf8) {
                print("Data\(postDataString)")
            } else {
                print("Failed to convert data to string")
            }
            if (error != nil) {
                completion(.error, data)
            } else {
                completion(.success, data)
            }
        }.resume()
    }
}
