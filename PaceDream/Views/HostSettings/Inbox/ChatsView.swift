//
//  ChatsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct ChatsView: View {
    @ObservedObject var inboxVM: InboxViewModel
    
    var body: some View {
        List(inboxVM.chats) { chat in
            HStack(alignment: .top) {
                Image(chat.users[0].profilePic!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 57, height: 57)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("\(chat.users[0].first_name) \(chat.users[0].last_name)")
                        .font(.body.bold())
                    
                    Text(chat.messages.last?.message ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                    
                }
                Spacer()
                VStack(alignment: .center, spacing: 13){
                    Text(chat.messages.last?.createdAt.formatted(date: .omitted, time: .shortened) ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    if chat.unreadCount != nil {
                        Text("\(chat.unreadCount!)")
                            .font(.caption2.bold())
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.appBlue).frame(width: 24, height: 24))
                    }
                }
            }.overlay {
                NavigationLink {
                    MessagesView(chat: chat).navigationBarBackButtonHidden()
                } label: {
                    EmptyView()
                }.opacity(0)
            }
        }
        .listStyle(.plain)
    }
}
