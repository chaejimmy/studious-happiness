////
//  NotificationSettingView.swift
//  bug-free-goggles
//
//  Created by Mac on 08/05/23.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var notificationEnable: Bool = false
    @State private var soundEnable: Bool = false
    @State private var vibrateEnable: Bool = false
    @State private var appUpdatesEnable: Bool = false
    
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
            
            Text("Notification")
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal)
            
            Group {
                Toggle("General Notification", isOn: $notificationEnable)
                Toggle("Sound", isOn: $soundEnable)
                Toggle("Vibrate", isOn: $vibrateEnable)
                Toggle("App Updates", isOn: $appUpdatesEnable)
            }
            .font(.system(size: 17, weight: .semibold))
            .padding(.horizontal)
            
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
