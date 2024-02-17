//
//  HostNotificationsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct HostNotificationsView: View {
    
    @ObservedObject var inboxVM: InboxViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                if !inboxVM.todayNotifications.isEmpty{
                    VStack(alignment: .leading) {
                        Text("Today")
                            .font(.system(size: 15, weight: .bold))
                            .padding(.top,10)
                            .padding(.leading,5)
                        
                        ForEach(inboxVM.todayNotifications, id: \.createdAt){ notification in
                            if notification.notificationUsers == .single {
                                SingleUserNotificationView(notification: notification)
                            }  else {
                                DoubleUserNotificationView(notification: notification)
                            }
                        }
                    }
                }
                
                if !inboxVM.weekNotifications.isEmpty{
                    Text("This Week")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.top,10)
                        .padding(.leading,5)
                    
                    
                    ForEach(inboxVM.weekNotifications, id: \.createdAt){ notification in
                        if notification.notificationUsers == .single {
                            SingleUserNotificationView(notification: notification)
                        }  else {
                            DoubleUserNotificationView(notification: notification)
                        }
                    }
                }
                
                if !inboxVM.monthNotifications.isEmpty{
                    
                    Text("This Month")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.top,10)
                        .padding(.leading,5)
                    
                    
                    ForEach(inboxVM.monthNotifications, id: \.createdAt){ notification in
                        if notification.notificationUsers == .single {
                            SingleUserNotificationView(notification: notification)
                        }  else {
                            DoubleUserNotificationView(notification: notification)
                        }
                    }
                }
                
                if !inboxVM.earlierNotifications.isEmpty{
                    
                    Text("Earlier")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.top,10)
                        .padding(.leading,5)
                    
                    
                    
                    ForEach(inboxVM.earlierNotifications, id: \.createdAt){ notification in
                        if notification.notificationUsers == .single {
                            SingleUserNotificationView(notification: notification)
                        }  else {
                            DoubleUserNotificationView(notification: notification)
                        }
                    }
                }
            }
            .padding()
        }
    }
}




struct SingleUserNotificationView: View{
    var notification: NotificationsModel
    
    var body: some View {
        HStack{
            Image(notification.userProfileImage[0])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading){
                
                
                if notification.notificationType == .review {
                    Text("Now you can give a review to **\(notification.username[0])** place")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text("**\(notification.username[0])** sent you a proposal.")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text(notification.timeElapsed)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("993C3C43"))
                
            }
            .padding(.top,10)
            
            Spacer()
            Image(notification.notificationImage ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60)
            
            
            
            
        }
        
    }
    
}



struct DoubleUserNotificationView: View{
    var notification: NotificationsModel
    
    var body: some View {
        
        
        HStack{
            ZStack(alignment: .leading) {
                
                Image(notification.userProfileImage[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                Image(notification.userProfileImage[1])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .padding(.leading,15)
                    .padding(.top,20)
                
            }
            
            
            VStack(alignment: .leading){
                if notification.notificationType == .proposal{
                    Text("**\(notification.username[0])** & **\(notification.username[1])** sent you a proposal.")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text("Now you can give a review to **\(notification.username[0])** & **\(notification.username[1])** place")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                Text(notification.timeElapsed)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("993C3C43"))
                
            }
            .padding(.top,10)
            
            Spacer()
            Image(notification.notificationImage ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60)
            
            
            
            
        }
    }
    
}
