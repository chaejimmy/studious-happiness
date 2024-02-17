//
//  SecurityView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 10/05/2023.
//


import SwiftUI

struct SecurityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isNotificationOn = true
    @State private var isSoudOn = false
    @State private var isVibrateOn = true
    @State private var isAppUpdateOn = true
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                Button {
                    print("clicked")
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
                
                Text("Security")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 10)
                    .padding(.leading,5)
                
                Toggle(isOn: $isNotificationOn) {
                    Text("Face ID")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.leading,5)
                .padding(.top,7)
                .padding(.trailing,15)
                
                Toggle(isOn: $isSoudOn) {
                    Text("Remember me")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.leading,5)
                .padding(.top,7)
                .padding(.trailing,15)
                
                Toggle(isOn: $isVibrateOn) {
                    Text("Touch ID")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.leading,5)
                .padding(.top,7)
                .padding(.trailing,15)
                
                Toggle(isOn: $isAppUpdateOn) {
                    Text("App Updates")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.leading,5)
                .padding(.top,7)
                .padding(.trailing,15)
                
                NavigationLink {
                    ChangePasswordView().navigationBarBackButtonHidden(true)
                } label: {
                    Text("Change Password").foregroundColor(.black)
                }
                .buttonStyle(PrimaryButtonStyle(background: Color("DarkWhite")))
                .disabled(false)
                .padding(.top,20)
                .padding(.trailing,15)
                
                Spacer() // Add spacer at the end to push the content up
            }
            .padding(.leading) // Add left
            .padding(.top,50) // Add top
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top) // Ignore the safe area at the top
        }
        .navigationBarBackButtonHidden(true)
              .navigationBarHidden(true)
    }
}





