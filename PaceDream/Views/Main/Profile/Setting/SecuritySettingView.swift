////
//  SecuritySettingView.swift
//  bug-free-goggles
//
//  Created by Mac on 08/05/23.
//

import SwiftUI

struct SecuritySettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var faceIdEnable: Bool = false
    @State private var rememberMeEnable: Bool = false
    @State private var touchIdEnable: Bool = false
    
    @State private var openChangePasswordView: Bool = false
    
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
            .padding(.leading)
            
            Text("Security")
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal)
            
            Group {
                Toggle("Face ID", isOn: $faceIdEnable)
                Toggle("Remember me", isOn: $rememberMeEnable)
                Toggle("Touch ID", isOn: $touchIdEnable)
            }
            .font(.system(size: 17, weight: .semibold))
            .padding(.horizontal)
            
            Button {
                openChangePasswordView = true
            } label: {
                Text("Change Password")
            }
            .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
            .padding(.vertical, 8)
            .padding(.horizontal)

            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $openChangePasswordView){
            ChangePasswordView()
        }
        
    }
}

struct SecuritySettingView_Previews: PreviewProvider {
    static var previews: some View {
        SecuritySettingView()
    }
}
