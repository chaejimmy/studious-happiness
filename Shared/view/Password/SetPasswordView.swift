//
//  SetPasswordView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct SetPasswordView: View {
    @ObservedObject var vm = BasicSetUpViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4){
                Text("Password")
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
            PasswordItemView(label: "Create password", placeHolder: "Enter password", password: $vm.password)
                .padding(.top, 12)
            Text("Passwords must have at least 8 characters")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(vm.passeordCheck ? 1 : 0)
            
            PasswordItemView(label: "Confirm password", placeHolder: "Enter confirm password", password: $vm.confirmPassword)
            
            Text("Passwords does not match")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(vm.confirmPasswordCheck ? 1 : 0)
            
  
            
    
            
            NavigationLink(destination: BasicSetUpView(), label:
                             {
                
                Text("Continue")
                
                
                     
            })
                .buttonStyle(PrimaryButtonStyle(isDisable: vm.passwordContinueDisable))
                .disabled(vm.passwordContinueDisable)
                .padding(.vertical, 12)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, -80)
        .navigationBarBackButtonHidden(true)
    }
}

struct SetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetPasswordView()
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
