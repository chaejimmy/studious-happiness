//
//  HostSettingView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI
import PopupView

struct HostSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @State private var selection = 0
    @State private var fullScreenCover = false
    @State var showingLogoutPopup = false
    
    @StateObject private var appState =  AppState.shared
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    //                    Button {
                    //                        selection = 0
                    //                        presentationMode.wrappedValue.dismiss()
                    //                    } label: {
                    //                        Image(systemName: "chevron.left")
                    //                            .resizable()
                    //                            .aspectRatio(contentMode: .fit)
                    //                            .frame(width: 10, height: 10)
                    //                            .foregroundColor(.black)
                    //                            .padding()
                    //                            .background(Color("DarkWhite"))
                    //                            .clipShape(Circle())
                    //                    }
                    Text("Settings")
                        .font(.system(size: 28, weight: .bold))
                }
                .padding(.bottom)
                .padding(.bottom)
                
                HStack {
                    Image("personIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        let userInfo = UserDefaultsCodable<UserAuthData>.init(key: "UserAuth").getObject()
                        if let firstN = userInfo?.data?.firstName, let lastN = userInfo?.data?.lastName {
                            Text("\(firstN) \(lastN)")
                                .font(.body.bold())
                            
                        } else {
                            Text("null")
                                .font(.body.bold())
                        }
                        
                        
                        NavigationLink {
                            EditProfileView().navigationBarBackButtonHidden(true)
                        } label: {
                            Text("View and edit profile")
                                .font(.callout)
                                .foregroundColor(.appBlue)
                        }
                    }
                }
                
                Divider()
                
                Button {
                    selection = 0
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        appState.hostMode = !appState.hostMode
                    }
                    
                } label: {
                    Text("Switch to \(appState.hostMode ? "Guest Mode": "Host Mode" )")
                        .font(.body.bold())
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                .background(Color.appBlue)
                .cornerRadius(30)
                .padding(.vertical)
                .padding(.bottom, 28)
                
                VStack(alignment: .center) {
                    NavigationLink {
                        BookingsView()
                    } label: {
                        HostSettingsSections(sectionName: "Bookings", sectionImage: "bookings", selected: selection == 1)
                            .padding(.bottom)
                    }
                    .onTapGesture {
                        selection = 1
                    }
                    
                    NavigationLink {
                        HostInboxView()
                    } label: {
                        HostSettingsSections(sectionName: "Inbox", sectionImage: "inbox", selected: selection == 2)
                            .padding(.bottom)
                    }
                    .onTapGesture {
                        selection = 2
                    }
                    
                    NavigationLink {
                        SpaceView()
                    } label: {
                        HostSettingsSections(sectionName: "Space", sectionImage: "space", selected: selection == 3)
                            .padding(.bottom)
                    }
                    .onTapGesture {
                        selection = 3
                    }
                    
                    if  appState.hostMode {
                        NavigationLink {
                            BusinessView()
                        } label: {
                            HostSettingsSections(sectionName: "Business", sectionImage: "chart", selected: selection == 4)
                                .padding(.bottom, 77)
                        }
                        .onTapGesture {
                            selection = 4
                        }
                    }
                    
                    
                    Button {
                        fullScreenCover.toggle()
                    } label: {
                        Text("Post your space")
                            .font(.body.bold())
                            .foregroundColor(.appBlue)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke().foregroundColor(.appBlue))
                    .padding(.vertical)
                    .fullScreenCover(isPresented: $fullScreenCover) {
                        PostHostingView()
                    }
                    
                    Divider()
                    
                    Button {
                        // selection = 0
                       
                        showingLogoutPopup = true
                    } label: {
                        HStack{
                            Image("logoutIcon")
                                .renderingMode(.template)
                            
                            Text("Logout")
                                .font(.body.bold())
                        }
                    }
                    .foregroundColor(.appRed)
                    .frame(width: 175, height: 50)
                    .background(Color.appRed.opacity(0.2))
                    .cornerRadius(25)
                    .padding(.vertical)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .popup(isPresented: $showingLogoutPopup) {
            LogoutView(isPresented: $showingLogoutPopup){
                isLoggedIn = false
            }
        } customize: {
            $0  .closeOnTapOutside(true)
                .dragToDismiss(true)
                .backgroundColor(.black.opacity(0.4))
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
            //.autohideIn(2)
        }
    }
}


struct LogoutView: View {
    
    @Binding var isPresented: Bool
    var logoutCallback: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Logout")
                .foregroundColor(.black)
                .font(.system(size: 24))
            
            Text("Are you sure you want to log out?")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            
            Button("Yes, log me out") {
                logoutCallback()
                isPresented = false
            }
            .buttonStyle(.plain)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(12)
   
            
//            Text("cancel")
//                .font(.system(size: 18, weight: .bold))
//                .foregroundStyle(.gray)
//                .onTapGesture {
//                    isPresented = false
//                }
           
          
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadowedStyle()
        .padding(.horizontal, 16)
    }
}




struct HostSettingView_Previews: PreviewProvider {
    static var previews: some View {
        HostSettingView()
    }
}

