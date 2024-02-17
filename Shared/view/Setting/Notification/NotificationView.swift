//
//  NotificationView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 10/05/2023.
//

import SwiftUI

struct NotificationView : View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isNotificationOn = true
    @State private var isSoudOn = false
    @State private var isVibrateOn = true
    @State private var isAppUpdateOn = true

    

    var body: some View {
        GeometryReader { geometry in
                   VStack(alignment: .leading) {
                    
                       
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
                        

                       Text("Notification")
                           .font(.system(size: 28, weight: .bold))
                           .padding(.top,15)
                           .padding(.leading,5)
                       
                       
                       
                       Toggle(isOn: $isNotificationOn) {
                                   
                           
                           Text("General Notification")
                               .font(.system(size: 17, weight: .semibold))
                               .foregroundColor(.primary)
                                  }
                                  .toggleStyle(SwitchToggleStyle(tint: .green))
                                  .padding(.leading,5)
                                  .padding(.top,7)
                                  .padding(.trailing,15)
                       
                       
                       Toggle(isOn: $isSoudOn) {
                                   
                           
                           Text("Sound")
                               .font(.system(size: 17, weight: .semibold))
                               .foregroundColor(.primary)
                                  }
                                  .toggleStyle(SwitchToggleStyle(tint: .green))
                                  .padding(.leading,5)
                                  .padding(.top,7)
                                  .padding(.trailing,15)
                       
                       
                       
                       Toggle(isOn: $isVibrateOn) {
                                   
                           
                           Text("Vibrate")
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
                       
                 

                       
                   }
                   .padding(.leading) // Add left
                   .navigationBarBackButtonHidden(true)
                   .navigationBarHidden(true)
        }
    }
    
}


