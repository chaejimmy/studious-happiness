////
//  ChatViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import SwiftUI
import PhotosUI

class MessageModel: Identifiable {
    var id: String
    var senderId: String
    var text: String
    var images: [String]
    
    init(id: String = UUID().uuidString, senderId: String, text: String, images: [String]) {
        self.id = id
        self.senderId = senderId
        self.text = text
        self.images = images
    }
}

class ChatViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    @Published var inputMessage: String = ""
    @State var avatarItem: PhotosPickerItem?
    @State var avatarImage: Image?
    let myUserId: String = "4AAB1CE3-0B0E-4573-8D3F-AE75272DA2BA"
    
    func prepareInitialData(sender: UserModel) {
        messages.append(MessageModel(senderId: myUserId, text: "Hi", images: []))
        messages.append(MessageModel(senderId: myUserId, text: "Thanks for your help! Can you please describe your review??", images: []))
        
        messages.append(MessageModel(senderId: myUserId, text: "", images: ["onboard1"]))
        
        messages.append(MessageModel(senderId: sender.id, text: "Hi", images: []))
        messages.append(MessageModel(senderId: sender.id, text: "Thanks for your help! Can you please describe your review??", images: []))
        
        messages.append(MessageModel(senderId: sender.id, text: "", images: ["onboard1", "onboard2"]))
        
        messages.append(MessageModel(senderId: myUserId, text: "Hi👋", images: []))
        messages.append(MessageModel(senderId: myUserId, text: "It’s fine, I’ll do it. thanks!", images: []))
        
        messages.append(MessageModel(senderId: myUserId, text: "", images: ["onboard1", "onboard2", "onboard3"]))
        messages.append(MessageModel(senderId: myUserId, text: "What about this room?", images: []))
        
        messages.append(MessageModel(senderId: sender.id, text: "Thank you so much!!", images: []))
        messages.append(MessageModel(senderId: sender.id, text: "Keep in touch with me.", images: []))
    }
}
