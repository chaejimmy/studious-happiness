////
//  SettingView.swift
//  bug-free-goggles
//
//  Created by Mac on 05/05/23.
//

import SwiftUI

struct SwitchHostingCardView: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)

                VStack(spacing: 8) {
                    Text("Switch to Hosting")
                        .foregroundColor(.blue)
                        .font(.circular(size:20,weight:.bold ))

                    Image(systemName: "arrow.left.arrow.right.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.black)

                    Text("Why Switch to Hosting?")
                        .foregroundColor(.black)
                        .font(.circular(size:20,weight:.book ))

                    Text("As a host, you can earn extra income by renting out your place. PaceDream provides a platform for connecting with guests, managing reservations, and getting paid securely.")
                        .foregroundColor(.black)
                        .font(.circular(size:14,weight:.book ))
                }
                .padding()
            }
        }
        .padding(.horizontal, 20)
    }
}
struct HostingButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
                .frame(height: 50)
            
            HStack {
                Image(systemName: "arrow.left.arrow.right.circle")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text("Switch to Hosting")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.headline)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @State var vm = SettingViewModel.shared
    @State var showSignOutSheet: Bool = false
    @State var showMyAccountItem: Bool = false
    @State var showVersionSheet: Bool = false
    
    @State var myAccountItem: MyAccount?
    var body: some View {
        //NavScrollView(title: "Settings", leftAction: { dismiss() }) {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView{
                SwitchModeButton(title: "Switch to host mode", action: {
                })
                .padding(.vertical)
                SettingContainer(title: "My Account") {
                    VStack(spacing: 16) {
                        ForEach(MyAccount.allCases, id: \.title){ item in
                            SettingItemView(title: item.title, image: item.image){
                                myAccountItem = item
                                showMyAccountItem = true
                            }
                        }
                        
                    }
                }
                .padding(.top, 8)
                .navigationDestination(isPresented: $showMyAccountItem) {
                    switch myAccountItem {
                    case .profile: ProfileSettingView()
                    case .notification: NotificationSettingView()
                    case .security: SecuritySettingView()
                    default: EmptyView()
                    }
                }
               
               // HostingButton()
                SettingContainer(title: "Information") {
                    VStack(spacing: 16) {
                        ForEach(Information.allCases, id: \.title){ item in
                            SettingItemView(title: item.title, image: item.image){
                                if item == Information.version {
                                    showVersionSheet = true
                                }
                            }
                        }
                    }
                }
                
                Button {
                    showSignOutSheet = true
                } label: {
                    Text("Sign Out")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                Spacer(minLength: 150)
            }}
        //}
        //.toolbar(.hidden, for: .navigationBar)
            .navigationTitle("Settings")
        .modal(present: $showSignOutSheet, view: SignOutSheet() {
            showSignOutSheet = false
        })
        .modal(present: $showVersionSheet, view: VersionUpdateSheet(
            title: "Using Now V 1.2.3.0",
            description: "Totel recommends that you update to the the latest version or a seamless enhanced performance of the app."
        ){
            showVersionSheet = false
        })
    }
}

struct SettingContainer<Content: View> : View {
    let title: String
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondaryGray)
                .padding(.horizontal)
            content()
        }
    }
}

struct SettingItemView: View {
    let title: String
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(image)
                    .frame(height: 40)
            }
            .padding(.horizontal)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingView()
        }
    }
}


enum MyAccount: CaseIterable {
    case profile
    case paymentInfo
    case notification
    case security
    case currency
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .paymentInfo: return "Payment Information"
        case .notification: return "Notification"
        case .security: return "Security"
        case .currency: return "Currency"
        }
    }
    
    var image: String {
        switch self {
        case .profile: return "profile"
        case .paymentInfo: return "cardIcon"
        case .notification: return "notification"
        case .security: return "lockIcon"
        case .currency: return "usdIcon"
        }
    }
}

enum Information: CaseIterable {
    case help
    case version
    case termsOfService
    case privacyPolicy
    
    var title: String {
        switch self {
        case .help: return "Help"
        case .version: return "Version"
        case .termsOfService: return "Terms of Service"
        case .privacyPolicy: return "Privacy Policy"
        }
    }
    
    var image: String {
        switch self {
        case .help: return "helpIcon"
        case .version: return "phoneIcon"
        case .termsOfService: return "termServiceIcon"
        case .privacyPolicy: return "privacyPolicyIcon"
        }
    }
}
