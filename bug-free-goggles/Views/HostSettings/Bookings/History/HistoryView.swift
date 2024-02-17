//
//  HistoryView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var bookingVM: BookingsViewModel
    
    var completeBookings: [BookingModel]{
        bookingVM.bookings.filter {$0.bookingStatus == .complete}
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(completeBookings){ booking in
                        BookingCard(booking: booking)
                    }
                }
            }
            
            Button {
                
            } label: {
                HStack{
                    Image("filterIcon")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    
                    Text("Filters")
                        .foregroundColor(.white)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.blue)
                    .frame(width: 136, height: 50)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 4, y: 10)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: -4, y: -10)
            )
            .padding()
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(bookingVM: BookingsViewModel())
    }
}
