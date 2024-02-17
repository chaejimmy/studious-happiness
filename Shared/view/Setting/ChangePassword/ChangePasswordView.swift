//
//  ChangePasswordView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 10/05/2023.
//



import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var vm = BasicSetUpViewModel.shared
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4){
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color("DarkWhite"))
                        .clipShape(Circle())
                }
                 

                Text("Change Password")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top,15)
                
                
                HStack(spacing: 8) {
                    Text("At least 8 digit should be in your password.")
                        .font(.system(size: 15, weight: .regular))
                    Button {
                        
                    } label: {
                        Text("help?")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.appPrimary)
                    }
                }
            }
            
            Text("By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from Totel and its affiliates to the number provided.")
                .font(.system(size: 13, weight: .regular)).foregroundColor(Color("993C3C43"))
            
            ChangePasswordItemView(label: "Create password", placeHolder: "Enter password", password: $vm.password)
                .padding(.trailing,15)

            Text("Passwords must have at least 8 characters")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .opacity(vm.passeordCheck ? 1 : 0)
            
            ChangePasswordItemView(label: "Confirm password", placeHolder: "Enter confirm password", password: $vm.confirmPassword)
                .padding(.trailing,15)

            
            Text("Passwords does not match")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(vm.confirmPasswordCheck ? 1 : 0)
            
  
            
    
            
            NavigationLink(destination: BasicSetUpView(), label:
                             {
                
                Text("Change Password")
                
                
                     
            })
                .buttonStyle(PrimaryButtonStyle(isDisable: vm.passwordContinueDisable))
                .disabled(vm.passwordContinueDisable)
                .padding(.vertical, 12)
                .padding(.trailing,15)

            
            Spacer()
        }
        .padding(.leading) // Add left
        .padding(.top,50) // Add top
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top) // Ignore the safe area at the top
    }
    
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetPasswordView()
    }
}

struct ChangePasswordItemView: View {
    let label: String
    let placeHolder: String
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
            
            CustomTextField(placeholder: placeHolder, value: $password, isSecureField: true)
        }
    }
}
