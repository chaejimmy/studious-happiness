//
//  InboxView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct HostInboxView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var inboxVM = InboxViewModel()
    @State private var selection = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                VStack(alignment: .leading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("DarkWhite"))
                            .clipShape(Circle())
                    }
                    
                    Text("Inbox")
                        .font(.system(size: 28, weight: .bold))
                }
                .padding([.horizontal, .bottom])
                .padding(.bottom)
                
                SelectionView()
            }
            .background(.white)
            switch(HostInboxTab(rawValue: selection)){
            case .messages: ChatsView(inboxVM: inboxVM)
            case .notifications: HostNotificationsView(inboxVM: inboxVM)
            case .none: EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading)
        .padding(.trailing)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func SelectionView() -> some View {
        var labels: [String]{
            return HostInboxTab.allCases.map{$0.title}
        }
        return CustomSegmentedControl(selection: $selection, segmentLabels: labels)
    }

}
