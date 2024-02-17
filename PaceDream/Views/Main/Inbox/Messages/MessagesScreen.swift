//
//  MessagesScreen.swift
//  Cheffy Designs
//
//  Created by Pratik on 11/05/23.
//

import SwiftUI

struct MessagesScreen: View {
    var users: [UserModel] = [
        UserModel(id: UUID().uuidString, name: "Stella Marium", lastMessageTime: "2:50 PM", unreadMessageCount: 2, status: .offline),
        UserModel(id: UUID().uuidString, name: "Amber Star", lastMessageTime: "12:10 PM", unreadMessageCount: 1, status: .online),
        UserModel(id: UUID().uuidString, name: "Stella Williums", lastMessageTime: "6:20 AM", unreadMessageCount: 0, status: .offline),
        UserModel(id: UUID().uuidString, name: "Pratik Gadhesariya", lastMessageTime: "12:15 PM", unreadMessageCount: 3, status: .offline),
        UserModel(id: UUID().uuidString, name: "Bansi Talaviya", lastMessageTime: "9:00 PM", unreadMessageCount: 2, status: .online),
        UserModel(id: UUID().uuidString, name: "Rushil Togadiya", lastMessageTime: "9:45 AM", unreadMessageCount: 0, status: .online),
    ]
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
//        VStack(spacing: 0) {
////            headerView(title: "Messages")
//
////            .navigationBarHidden(true)
//        }
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        ChatView(user: user)
                    } label: {
                        UserCell(user: user)
                    }
                }
                .listRowSeparator(.visible, edges: [.bottom])
            }
            .listStyle(.plain)
            //.navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "multiply")
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
                .padding(8)
                .background {
                    Circle()
                        .fill(Color.secondary.opacity(0.1))
                }
        }
        .frame(width: 35, height: 35)
    }
    
    private func headerView(title: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 28, weight: .bold, design: .default))
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image("confirmIcon")
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            
            Divider()
        }
    }
}

struct UserModel: Identifiable {
    let id: String
    let profilePicture: String = "moc_profilePic"
    let name: String
    let lastMessage: String = "Where are you now? I'm waiting for your room key"
    let lastMessageTime: String
    let unreadMessageCount: Int
    let status: UserActiveStatus
}

enum UserActiveStatus {
    case online, offline
    
    var title: String {
        switch self {
        case .online:
            return "Online"
        case .offline:
            return "Offline"
        }
    }
    
    var color: Color {
        switch self {
        case .online:
            return .green
        case .offline:
            return .red
        }
    }
}

struct UserCell: View {
    let user: UserModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(user.profilePicture)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(user.name)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                    
                    Spacer()
                    
                    Text(user.lastMessageTime)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                HStack(alignment: .top) {
                    Text(user.lastMessage)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    Spacer(minLength: 0)
                    
                    if user.unreadMessageCount > 0 {
                        Circle()
                            .fill(.blue)
                            .frame(width: 24, height: 24, alignment: .center)
                            .overlay {
                                
                                Text("\(user.unreadMessageCount)")
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                                    .foregroundColor(.white)
                            }
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct MessagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        AcceptProposalView()
    }
}

struct AcceptProposalView: View {
    var isAccepted: Bool = false
    
    var body: some View {
        HStack {
            if isAccepted {
                Spacer(minLength: 30)
            }
            VStack {
                Image("onboard1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: isAccepted ? 173 : 149)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Circle()
                            .frame(width: 6, height: 6)
                        Text("Hourly")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.darkGreen)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(Color.lightGreen)
                    .clipShape(Capsule())
                    
                    Text("Hotel Assenzio Karoeke")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 2)
                    Text("25 Apr 2023 - 28 Apr 2023")
                        .font(.system(size: 14, weight: .medium))
                    
                    Group {
                        Text("Place: ")
                            .font(.system(size: 15, weight: .regular))
                        +
                        Text("Bristol")
                            .font(.system(size: 15, weight: .medium))
                    }.padding(.top, 6)
                    
                    Text("Proposed Amount-$18 / Hour")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.top, 2)
                    
                    Group {
                        if isAccepted {
                            Text("You have accepted the proposal")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.darkGreen)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 8)
                                .background(Color.lightGreen)
                                .clipShape(Capsule())
                        } else {
                            HStack {
                                Button {
                                    
                                } label: {
                                    Text("Accept")
                                }
                                .buttonStyle(FixedPaddingButtonStyle())
                                
                                Button {
                                    
                                } label: {
                                    Text("Decline")
                                }
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.horizontal, 32)
                                .padding(.vertical, 14)
                                .foregroundColor(.lightRed)
                                .background(
                                    Color.lightRed,
                                    in: Capsule().stroke()
                                )
                                .contentShape(Rectangle())
                            }
                        }
                    }
                    .padding(.top, 6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.white)
            }
            .overlay(
                Color.neutral700,
                in: RoundedRectangle(cornerRadius: 10).stroke()
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if !isAccepted {
                Spacer(minLength: 30)
            }
        }
    }
}
