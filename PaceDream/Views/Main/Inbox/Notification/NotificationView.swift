////
//  NotificationView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI

struct NotificationView: View {
    @State private var showHotelDetailView: Bool = false
    enum Inboxes: String, CaseIterable, Identifiable {
        case Notifications, Messages
        var id: Self { self }
    }
    @State private var selectedInbox: Inboxes = .Notifications
    
    var body: some View {
        VStack(alignment: .leading) {
             ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                ForEach(categorizeDates(notifications).sorted(by: { $0.key > $1.key }), id: \.key) { key, value in
                                    LabelContentView(title: key) {
                                        VStack(spacing: 12) {
                                            ForEach(value.sorted(by: { $0.createdAt > $1.createdAt }), id: \.id) { item in
                                                NotificationItemView(notificationItem: item){
                                                    showHotelDetailView = true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
            
        }
        .navigationDestination(isPresented: $showHotelDetailView) {
            CleaningClearingView()
            //HotelDetailsView(data: PreviewData.bookingData)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NotificationView()
        }
    }
}
