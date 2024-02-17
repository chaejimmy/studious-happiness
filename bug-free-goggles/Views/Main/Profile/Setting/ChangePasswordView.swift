////
//  ChangePasswordView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    
    var isDisable: Bool {
        currentPassword.isEmpty || newPassword.isEmpty || passeordCheck
    }
    
    var passeordCheck: Bool {
        newPassword.isNotEmpty && newPassword.count < 8
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                dismiss()
            } label: {
                Image("arrowBackIcon")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(14)
                    .background(Color.darkWhite)
                    .clipShape(Circle())
            }
            
            Text("Change Password")
                .font(.system(size: 28, weight: .bold))
            
            VStack(spacing: 4){
                HStack(spacing: 4) {
                    Text("At least 8 digit should be in your password.")
                    Text("Help?")
                        .foregroundColor(.appPrimary)
                    Spacer()
                }
                .font(.system(size: 15, weight: .regular))
                
                Text("By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from Totel and its affiliates to the number provided.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondaryGray)
            }
            
            PasswordItemView(label: "Current password", placeHolder: "Enter current password", password: $currentPassword)
            
            
            PasswordItemView(label: "New password", placeHolder: "Enter new password", password: $newPassword)
            
            Text("Passwords must have at least 8 characters")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(passeordCheck ? 1 : 0)
            
            Button {
            } label: {
                Text("Change Password")
            }
            .buttonStyle(PrimaryButtonStyle(isDisable: isDisable))
            .disabled(isDisable)

            Spacer()
        }
        .padding(.horizontal)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
