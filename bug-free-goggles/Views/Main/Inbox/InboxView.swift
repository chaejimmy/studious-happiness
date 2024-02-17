////
//  InboxView.swift
//  bug-free-goggles
//
//  Created by Mac on 19/07/2023.
//

import SwiftUI

struct InboxView: View {
    @State private var showHotelDetailView: Bool = false
    enum Inboxes: String, CaseIterable, Identifiable {
        case Notifications, Messages
        var id: Self { self }
    }
    @State private var selectedInbox: Inboxes = .Notifications
    
    var body: some View {
       
            VStack(alignment: .leading) {
                
                Text("Inbox")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.horizontal)
                Picker("Inbox", selection: $selectedInbox) {
                    ForEach(Inboxes.allCases) { inbox in
                        Text(inbox.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Spacer()
                
                if selectedInbox == .Notifications {
                    NotificationView()
                } else {
                    MessagesScreen()
                }
                
            }
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
