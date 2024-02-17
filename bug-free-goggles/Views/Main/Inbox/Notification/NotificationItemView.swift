////
//  NotificationItemView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI

struct NotificationItemView: View {
    var notificationItem: NotificationItem
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                ProfileImageView(users: notificationItem.profiles)
                
                VStack(alignment: .leading, spacing: 0) {
                    switch notificationItem.type {
                    case .your_review:
                        YouCanGiveReviewView(user: notificationItem.profiles[0])
                    case .give_you_a_review:
                        GiveYouReview(user: notificationItem.profiles[0])
                    case .send_proposal:
                        SendProposalView(users: notificationItem.profiles)
                    }
                    Text(notificationItem.createdAt.timeAgoDisplay())
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.secondaryGray)
                }
                Spacer()
                Image(notificationItem.profiles[0].coverImage)
                    .resizable()
                    .frame(width: 76, height: 50)
            }
            .padding(.horizontal)
        }
    }
    
    func YouCanGiveReviewView(user: NotificationUserProfile) -> some View {
        Group {
            Text("Now you can give a review to ")
            + Text(user.username)
                .bold()
            + Text("’s place")
        }
        .multilineTextAlignment(.leading)
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(.black)
    }
    
    func GiveYouReview(user: NotificationUserProfile) -> some View {
        Group {
            Text(user.username)
                .bold()
            + Text(" give you a review: ")
            + Text("@Konsikan")
                .foregroundColor(.appPrimary)
            + Text(" exctly..")
        }
        .multilineTextAlignment(.leading)
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(.black)
    }
    
    func SendProposalView(users: [NotificationUserProfile]) -> some View {
        Group {
            if users.count > 1 {
                HStack {
                    Text(users[0].username)
                        .bold()
                    + Text(" & ")
                    + Text(users[1].username)
                        .bold()
                    + Text(" send you a proposal.")
                }
            } else {
                Text(users[0].username)
                    .bold()
                + Text(" Send you a proposal.")
            }
        }
        .multilineTextAlignment(.leading)
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(.black)
    }
    
    func ProfileImageView(users: [NotificationUserProfile]) -> some View {
        Group {
            if users.count > 1{
                DoubleProfileImage(users: users)
            } else {
                SingleProfileImage(user: users[0])
            }
        }
    }
}

struct NotificationItemView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationItemView(notificationItem: notifications[0]){}
    }
}

struct SingleProfileImage: View {
    var user: NotificationUserProfile
    
    var body: some View {
        Image(user.image)
            .resizable()
            .frame(width: 44, height: 44)
    }
}

struct DoubleProfileImage: View {
    var users: [NotificationUserProfile]
    
    var body: some View {
        ZStack {
            Image(users[0].image)
                .resizable()
                .frame(width: 32, height: 32)
            
            
            Image(users[1].image)
                .resizable()
                .frame(width: 32, height: 32)
                .overlay(
                    Circle()
                    .stroke(Color.white, lineWidth: 1.5)
                )
                .offset(x: 12, y: 12)
                
        }
        .frame(width: 44, height: 44, alignment: .topLeading)
    }
}
