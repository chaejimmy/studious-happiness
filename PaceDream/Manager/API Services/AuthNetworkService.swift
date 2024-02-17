////
//  AuthService.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

class AuthNetworkService{

    
    func checkhEmail(emailcheck: EmailCheckRequest) async throws -> CheckEmailData {
        let response: CheckEmailData = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.checkEmail),
            body: emailcheck
        )
        return response
    }
    
    func signUpWithPhone(phoneSignUpRequest: PhoneSignUpRequest) async throws -> Response<UserAuthData>{
        let response: Response<UserAuthData> = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.signUp),
            body: phoneSignUpRequest
        )
        return response
    }
    
    func loginWithEmail(emailLoginRequest: EmailLoginRequest) async throws -> UserAuthData {
        let response: UserAuthData = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.login),
            body: emailLoginRequest
        )
        return response
    }
    
    func loginWithPhone(phoneLoginRequest: PhoneLoginRequest) async throws -> Response<UserAuthData>{
        let response: Response<UserAuthData> = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.login),
            body: phoneLoginRequest
        )
        return response
    }
    
    func sendOPT(sendOtpRequest: SendOtpRequest) async throws {
        let response: Response<String> = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.sendOtp),
            body: sendOtpRequest
        )
        let _ = try response.getData()
        return
    }
    
    func verifyOTP(verifyOtpRequest: VerifyOtpRequest) async throws {
        let response: Response<String> = try await NetworkUtility.shared.request(
            endpoint: Endpoint(AuthEndpoint.verifyOtp),
            body: verifyOtpRequest)
        let _ = try response.getData()
        return
    }
}
