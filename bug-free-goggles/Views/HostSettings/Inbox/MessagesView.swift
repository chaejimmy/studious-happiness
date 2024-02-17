//
//  MessagesView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct MessagesView: View {
    let chat: ChatsModel
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    var body: some View {
        Group {
            HStack(alignment: .center) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .font(.body.bold())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                }
                
                HStack(alignment: .center) {
                    Image(chat.users[0].profilePic ?? "")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 1){
                        Text(chat.name)
                            .font(.body.bold())
                        
                        HStack(alignment: .top, spacing: 0) {
                            Text("Online")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Circle()
                                .fill(Color(red: 0.2, green: 0.78, blue: 0.35))
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                
                Spacer()
                
                Image("more")
                    .frame(width: 24, height: 24)
                
            }
            .padding(.horizontal)
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack {
                        ForEach(0..<chat.messages.count, id: \.self){i in
                            HStack {
                                if chat.messages[i].sender == "me"{
                                    Spacer()
                                }
                                
                                if(chat.messages[i].chatMedia != nil){
                                    LazyVStack(alignment: .trailing) {
                                        LazyHGrid(rows: columns, alignment: .top) {
                                            ForEach((chat.messages[i].chatMedia!).reversed(), id: \.self){
                                                Image($0)
                                                    .aspectRatio(contentMode: .fill)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            }
                                        }
                                        Text(chat.messages[i].message)
                                            .foregroundColor(chat.messages[i].sender == "me" ? .white : .black)
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 6)
                                            .background(
                                                chat.messages[i].sender == "me" ?
                                                RoundedCornerRectangle(cornerRadius: 20, corners: [.topLeft, .bottomLeft, .bottomRight])
                                                    .fill (Color.appBlue)
                                                :
                                                    RoundedCornerRectangle(cornerRadius: 20, corners: [.topRight, .bottomLeft, .bottomRight])
                                                    .fill (Color(.lightGray).opacity(0.1))
                                                
                                            )
                                    }
                                    
                                } else if (i + 1 != chat.messages.count && (chat.messages[i].sender == chat.messages[i+1].sender) && chat.messages[i+1].chatMedia == nil) {
                                    Text(chat.messages[i].message)
                                        .foregroundColor(chat.messages[i].sender == "me" ? .white: .black)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(chat.messages[i].sender == "me" ? Color.appBlue : Color(.lightGray).opacity(0.1))
                                        )
                                    
                                } else {
                                    Text(chat.messages[i].message)
                                        .foregroundColor(chat.messages[i].sender == "me" ? .white : .black)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 6)
                                        .background(
                                            chat.messages[i].sender == "me" ?
                                            RoundedCornerRectangle(cornerRadius: 20, corners: [.topLeft, .topRight, .bottomLeft])
                                                .fill (Color.appBlue)
                                            :
                                                RoundedCornerRectangle(cornerRadius: 20, corners: [.topLeft, .topRight, .bottomRight])
                                                .fill (Color(.lightGray).opacity(0.1))
                                            
                                        )
                                }
                                
                                if chat.messages[i].sender != "me"{
                                    Spacer()
                                }
                            }
                        }
                        HStack {
                            ZStack(alignment: .center) {
                                Image("typing")
                                    .resizable()
                                    .frame(width: 50, height: 30)
                                
                                HStack(spacing: 3) {
                                    ForEach(0...2, id: \.self){
                                        Circle()
                                            .fill(Color(red: 0.24, green: 0.24, blue: 0.26).opacity($0 != 1 ? 0.6 : 0.3))
                                            .frame(width: 6, height: 6)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .id("Empty")
                    }
                    .padding()
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo("Empty", anchor: .bottom)
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

