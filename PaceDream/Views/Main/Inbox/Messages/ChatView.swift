////
//  ChatView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    let user: UserModel
    
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState var focussed
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                headerView
                ScrollView {
                    VStack {
                        ForEach(viewModel.messages) { message in
                            MessageCellView(message: message, currentUserId: viewModel.myUserId)
                        }
                    }
                    .padding(16)
                }
                
                inputField
                    .padding(.top, 5)
                    .background(Color.white)
            }
            
//            VStack(spacing: 0) {
//                Spacer(minLength: 0)
//
//                inputField
//                    .padding(.top)
//                    .background(Color.white)
//            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.prepareInitialData(sender: user)
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("arrowBackIcon")
                }
                .buttonStyle(.plain)
                
                Image(user.profilePicture)
                    .frame(width: 36, height: 36, alignment: .center)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(user.name)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                    
                    HStack(spacing: 5) {
                        Text(user.status.title)
                            .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(.secondary)
                        
                        Circle()
                            .fill(user.status.color)
                            .frame(width: 6, height: 6)
                            .offset(y: -3)
                    }
                }
                Spacer()
                
                Button {
                    // handle more actions
                } label: {
                    Image("moreIcon")
                        .frame(width: 35, height: 35)
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            
            Divider()
        }
    }
    
    private var inputField: some View {
        HStack(spacing: 16) {
            PhotosPicker(selection: $viewModel.avatarItem, matching: .images) {
                Image("AttachmentIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            .onChange(of: viewModel.avatarItem) { _ in
                        Task {
                            if let data = try? await viewModel.avatarItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    viewModel.avatarImage = Image(uiImage: uiImage)
                                    return
                                }
                            }

                            print("Failed")
                        }
                    }
//            PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
            
//            Button {
//                // Attachment
//            } label: {
//                Image("AttachmentIcon")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30, height: 30)
//            }
            
            HStack {
                TextField("Type here!", text: $viewModel.inputMessage, axis: .vertical)
                    .focused($focussed)
                    .lineLimit(1...5)
                    .padding(.leading, 10)
                
                Button {
                    
                } label: {
                    Image("emoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(10)
            .background {
                Capsule()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.969))
            }
            
            Button {
                // send
                focussed = false
            } label: {
                Image("up_arrow")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .padding(5)
            .background {
                Circle()
                    .fill(Color(red: 0, green: 0.341, blue: 1))
            }
        }
        .padding([.horizontal, .bottom], 8)
    }
}

struct MessageCellView: View {
    let message: MessageModel
    let currentUserId: String
    
    var body: some View {
        Group {
            if !message.text.isEmpty {
                Text(message.text)
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .foregroundColor(message.senderId == currentUserId ? .white : .primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background {
                        RoundedCorners(color: message.senderId == currentUserId ? Color(red: 0, green: 0.341, blue: 1) : Color(red: 0.949, green: 0.949, blue: 0.969),
                                       tl: 20,
                                       tr: 20,
                                       bl: message.senderId == currentUserId ? 20 : 0,
                                       br: message.senderId == currentUserId ? 0 : 20)
                    }
            } else if !message.images.isEmpty {
                imageCollectionView
                    .frame(height: 253)
                    .frame(maxWidth: .infinity)
                    .clipped()
            }
        }
        .frame(maxWidth: .infinity, alignment: message.senderId == currentUserId ? .trailing : .leading)
    }
    
    @ViewBuilder
    private var imageCollectionView: some View {
        let spacing: CGFloat = 8
        
        if message.images.count == 1 {
            GeometryReader { bounds in
                Image(message.images[0])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: bounds.size.width, height: bounds.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        } else if message.images.count == 2 {
            GeometryReader { bounds in
                HStack(spacing: spacing) {
                    Image(message.images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (bounds.size.width/2) - (spacing/2), height: bounds.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(message.images[1])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (bounds.size.width/2) - (spacing/2), height: bounds.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        } else if message.images.count == 3 {
            GeometryReader { bounds in
                HStack(spacing: spacing) {
                    Image(message.images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (bounds.size.width/2) - (spacing/2), height: bounds.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: spacing) {
                        Image(message.images[1])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: (bounds.size.height / 2) - spacing/2)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Image(message.images[2])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: (bounds.size.height / 2) - spacing/2)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(width: (bounds.size.width/2) - (spacing/2), height: bounds.size.height)
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: UserModel(id: UUID().uuidString, name: "Stella Marium", lastMessageTime: "2:50 PM", unreadMessageCount: 2, status: .offline))
    }
}
