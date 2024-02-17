//
//  SettingView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 10/05/2023.
//

import SwiftUI
import PartialSheet

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresentingVersionSheet = false
    @State private var isPresentingSignOutSheet = false


    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color("DarkWhite"))
                                .clipShape(Circle())
                        }
                         

                        Text("Settings")
                            .font(.system(size: 28, weight: .bold))
                            .padding(.top,15)
                            .padding(.leading,5)

                        
                        Text("My Account")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color("993C3C43"))
                            .padding(.top,7)
                            .padding(.leading,7)
                        
                        Group {
                            
                            
                            NavigationLink {
                                EditProfileView().navigationBarBackButtonHidden(true)
                            } label: {
                                SettingItem(title: "Profile", image: "person",isText: false)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            
                            SettingItem(title: "Payment Information", image: "credit_card",isText: false)
                            NavigationLink {
                                NotificationView()
                            } label: {
                                SettingItem(title: "Notification", image: "notifications_none",isText: false)
                            }
                            .buttonStyle(PlainButtonStyle()) // Apply plain button style

                            
                            NavigationLink {
                                SecurityView().navigationBarBackButtonHidden(true)
                            } label: {
                                SettingItem(title: "Security", image: "lock_outline",isText: false)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                       
                        HStack{
                            Text("Currency")
                                .font(.system(size: 16, weight: .bold))

                            Spacer()
                            
                     
                            Text("$USD")
                                .font(.system(size: 14))
                                .padding()
                                .frame(width: 70, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(Color("DarkWhite"))
                                )

                            
                        }
                        .padding(.leading,7)
                        .padding(.trailing,14)
                        .padding(.top,3)
                        
                        
                        Text("Information")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color("993C3C43"))
                            .padding(.top,7)
                            .padding(.leading,7)
                        
                        
                        Group {
                            SettingItem(title:"Help", image:"help_outline",isText: false)
                            Button {
                                isPresentingVersionSheet = true;
                            } label: {
                                SettingItem(title:"Version", image:"phone_android",isText: false)
                            }
                            .buttonStyle(PlainButtonStyle())

                               
     
                            SettingItem(title:"Terms of Service", image:"Group",isText: false)
                            SettingItem(title:"Privacy Policy", image:"approval",isText: false)
                        }
                        
                        
                        Button {
                            isPresentingSignOutSheet = true;
                        } label: {
                            Text("Sign Out")
                                .font(.system(size: 20))
                                .foregroundColor(Color.red)
                                .padding(.top,8)
                                .padding(.leading,7)
                        }
                        .buttonStyle(PlainButtonStyle())
             }
                    .padding(.leading) // Add left
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.top)
                    .partialSheet(isPresented: $isPresentingVersionSheet,
                                  content: VersionSheetView.init)
                    .partialSheet(isPresented: $isPresentingSignOutSheet,
                                  content: SignOutSheetView.init)
             
             
                }
                
                       
                   }
                  
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
     
      
    }



    struct SettingItem: View {
        var title: String
        var image: String
        var isText:Bool
      
        
        var body: some View {
            HStack{
                Text(title)
                    .font(.system(size: 17, weight: .bold))

                Spacer()
                
                ImageOnCircle(icon: image, radius: 20, circleColor: Color("DarkWhite"))
                
            }
            .padding(.leading,7)
            .padding(.trailing,14)
            .padding(.top,5)


            
        }
        
        
    }
}


struct ImageOnCircle: View {
    
    let icon: String
    let radius: CGFloat
    let circleColor: Color
    var squareSide: CGFloat {
        1.5.squareRoot() * radius
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
            
            Image(icon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: squareSide, height: squareSide)
            
        }
        
    }
}


func VersionSheetContent() -> some View {
    ZStack {
              Color.white // Background color
              
              VStack {
                  Text("This is a sheet")
                      .font(.title)
                      .padding()
                  
                  Spacer()
                  
                  Button("Dismiss") {
                  }
                  .padding()
              }
              .frame(height: 200)
              .background(Color.lightGray)
              .cornerRadius(16)
              .shadow(radius: 8)
              .padding()
          }
          .edgesIgnoringSafeArea(.all)
    }

struct VersionSheetView: View {
    @State private var longer: Bool = false
    @State private var text: String = "some text"

    var body: some View {
        VStack(alignment: .leading){
            HStack {
              
       
                
                Text("Version")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                
                Button {
                   
                } label: {
                    ZStack {
                                Circle()
                                    .foregroundColor(Color("DarkWhite"))
                                    .frame(width: 35, height: 35)
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("993C3C43"))
                                    .font(.system(size: 17, weight: .bold))
                            }                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top, -30)

       
            Text("Using Now V 1.2.3.0")
                .font(.system(size: 18, weight: .bold))
                .padding(.top,10)

            
            
            Text("Totel recommends that you update to the the latest version or a seamless enhanced performance of the app.")
                .font(.system(size: 17))
                .foregroundColor(Color("993C3C43"))
                .padding(.top, 5)
            
            
            VStack(spacing: 12) {
                
                NavigationLink {
                    LoginInView(isForLogin: true)
                } label: {
                    Text("Update Now")
                }
                .buttonStyle(PrimaryButtonStyle(background: .appPrimary))
                .padding(.top,10)

                
                
                NavigationLink {
                    LoginInView(isForLogin: false)
                } label: {
                    Text("No, thanks").foregroundColor(.black)
                }
                .buttonStyle(PrimaryButtonStyle(background: Color("DarkWhite")))


            }

          
        }
        .frame(height: 300)
        .padding(.trailing,15)
        .padding(.leading,15)
        
        
    }
}


struct SignOutSheetView: View {
    @State private var longer: Bool = false
    @State private var text: String = "some text"

    var body: some View {
        VStack(alignment: .leading){
            HStack {
              
       
                
                Text("Are you sure you want to Sign Out?")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                
                Button {
                   
                } label: {
                    ZStack {
                                Circle()
                                    .foregroundColor(Color("DarkWhite"))
                                    .frame(width: 35, height: 35)
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("993C3C43"))
                                    .font(.system(size: 17, weight: .bold))
                            }                }
                .buttonStyle(PlainButtonStyle())

            }

            
            VStack(spacing: 12) {
                
                NavigationLink {
                    LoginInView(isForLogin: true)
                } label: {
                    Text("Yes, Sign Out")
                }
                .buttonStyle(PrimaryButtonStyle(background: .red))
                .padding(.top,5)

                
                
                NavigationLink {
                    LoginInView(isForLogin: false)
                } label: {
                    Text("Cancel").foregroundColor(.black).font(.system(size: 17, weight: .semibold))
                }
                .buttonStyle(PrimaryButtonStyle(background: Color("DarkWhite")))
    


            }

          
        }
        .frame(height: 150)
        .padding(.trailing,15)
        .padding(.leading,15)
        
        
    }
}




