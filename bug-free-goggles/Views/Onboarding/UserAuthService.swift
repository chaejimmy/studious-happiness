////
//  UserAuthService.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import SwiftUI
import GoogleSignIn

class UserAuthService {
    
    func signIn(completion: @escaping (Bool, String?) -> Void){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController,
             let clientId = UIApplication.clientId
        else {
           completion(false, nil)
           return
       }

        let signInConfig = GIDConfiguration(clientID: clientId)
        
        GIDSignIn.sharedInstance.configuration = signInConfig
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
               print(error.localizedDescription)
                completion(false, nil)
               return
             }
            guard let user = result?.user
            else {
                print("*****","Google failed")
                completion(false, nil)
                return
            }
            print("****** Google", user.accessToken.tokenString)
            completion(true, user.accessToken.tokenString)
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
    }
}
