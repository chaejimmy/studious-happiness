////
//  SetPasswordView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI

struct SetPasswordView: View {
    @ObservedObject var vm = OnboardingViewModel.shared
    var authFlowType: AuthFlowType
    var continueDisable: Bool {
        authFlowType == .login ? vm.loginPasswordContinueDisable : vm.passwordContinueDisable
    }
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading) {
            content
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4){
                Text(authFlowType == .forget_password ? "New Password" : "Password")
                    .font(.system(size: 28, weight: .bold))
                
                HStack(spacing: 8) {
                    Text("At least 8 digit.")
                        .font(.system(size: 15, weight: .regular))
                    Button {
                        
                    } label: {
                        Text("help?")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.appPrimary)
                    }
                }
            }
            PasswordItemView(label: authFlowType == .login ? "Your password" : "Create password", placeHolder: "Enter password", password: $vm.password)
                .padding(.top, 12)
            if vm.passeordCheck {
                Text("Passwords must have at least 8 characters")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.red)
                    .padding(.top, -8)
            }
            
            if authFlowType != .login {
                PasswordItemView(label: "Confirm password", placeHolder: "Enter confirm password", password: $vm.confirmPassword)
                
                if vm.confirmPasswordCheck {
                    Text("Passwords does not match")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.red)
                        .padding(.top, -8)
                }
            }
            
            Button {
                if authFlowType == .login {
                    vm.loginWithPhone()
                } else {
                    vm.showBasicSetUp = true
                }
            } label: {
                Text("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(isDisable: continueDisable))
            .disabled(continueDisable)
            .padding(.top, 12)
            .padding(.bottom, 4)
            
            if authFlowType == .login {
                Button {
                    
                } label: {
                    Text("Forgot Password?")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.secondaryGray)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationDestination(isPresented: $vm.showBasicSetUp){
            BasicSetUpView()
        }
        .navigationDestination(isPresented: $vm.openMainView) {
            MainView()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct SetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetPasswordView(authFlowType: .signup)
    }
}

struct PasswordItemView: View {
    let label: String
    let placeHolder: String
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
            
            CustomTextField(placeholder: placeHolder, value: $password, isSecureField: true)
        }
    }
}

