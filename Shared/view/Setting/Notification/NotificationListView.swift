//
//  NotificationListView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//



import SwiftUI

struct NotificationListView : View {
    
    @Environment(\.presentationMode) var presentationMode
  
    

    var body: some View {
       
        ScrollView {
            
            GeometryReader { geometry in
                       VStack(alignment: .leading) {
                        
                                                

                           Text("Notification")
                               .font(.system(size: 28, weight: .bold))
                               .padding(.top,15)
                               .padding(.leading,5)
                           
                           
                        
                           Group {
                               Text("Today")
                                   .font(.system(size: 15, weight: .bold))
                                   .padding(.top,10)
                                   .padding(.leading,5)
                               
                               
                               SingleUserNotificationView(banner: "Rectangle", profile: "Oval")
                               DoubleUserNotificationView(banner: "Rectangle (2)")
                               SingleUserNotificationView(banner: "Rectangle",profile: "Oval (2)")
                               SingleUserNotificationView(banner: "Rectangle (1)",profile: "Oval3")

                               Text("This Week")
                                   .font(.system(size: 15, weight: .bold))
                                   .padding(.top,10)
                                   .padding(.leading,5)
                               
                               
                               SingleUserNotificationView(banner: "Rectangle",profile: "Oval (2)")

                           }
                           
                           
                        
                           
                           Group{
                               
                               Text("This Month")
                                   .font(.system(size: 15, weight: .bold))
                                   .padding(.top,10)
                                   .padding(.leading,5)
                               
                               
                               DoubleUserNotificationView(banner: "Rectangle (1)")
                               SingleUserNotificationView(banner: "Rectangle",profile: "Oval")
                               SingleUserNotificationView(banner: "Rectangle (2)",profile: "Oval (2)")

                               
                               
                               Text("Earlier")
                                   .font(.system(size: 15, weight: .bold))
                                   .padding(.top,10)
                                   .padding(.leading,5)
                               
                               
                             
                               SingleUserNotificationView(banner: "Rectangle",profile: "Oval3")
                           }



                          
                       }
                       .padding(.leading)
                       .padding(.trailing)
                       .navigationBarBackButtonHidden(true)
                       .navigationBarHidden(true)
                
                Spacer()
            }
        }
        
    }
    
}


struct SingleUserNotificationView: View{
    var banner: String
    var profile: String
    var body: some View {
       
        
        HStack{
            Image(profile)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading){
                
         
                
                Text("Now you can give a review to")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                Text("stella_sf’s!")
                .foregroundColor(.black)
                .font(.system(size: 13, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)
                
                Text("place")
                .foregroundColor(.black)
                .font(.system(size: 13))
                .fixedSize(horizontal: false, vertical: true)
                
                
                Text("5 Min Ago")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("993C3C43"))
                
            }
            .padding(.top,10)

            Spacer()
            Image(banner)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60)
                
                
            
            
        }
        
    }
    
}



struct DoubleUserNotificationView: View{
    
    var banner : String
    var body: some View {
       
        
        HStack{
            
            
            
            ZStack(alignment: .leading) {
                
                Image("Oval")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                Image("Oval2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .padding(.leading,15)
                    .padding(.top,20)

            }
            
            
            VStack(alignment: .leading){
                
         
                
                HStack {
                    Text("sugeevan_svg")
                      
                            .foregroundColor(.black)
                            .font(.system(size: 13,weight: .semibold))
                            .fixedSize(horizontal: false, vertical: true)
                     
                    Text("&")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                            .fixedSize(horizontal: false, vertical: true)
                           
                    Text("jamestalan")
                            .foregroundColor(.black)
                            .font(.system(size: 13,weight: .semibold))
                            .fixedSize(horizontal: false, vertical: true)
                }
                
              Text("send you a proposal.")
                      .foregroundColor(.black)
                     .font(.system(size: 13))
                     .fixedSize(horizontal: false, vertical: true)
                    
                
                Text("Just now")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("993C3C43"))
                
            }
            .padding(.top,10)

            Spacer()
            Image(banner)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60)
                
                
            
            
        }
    }
    
}
