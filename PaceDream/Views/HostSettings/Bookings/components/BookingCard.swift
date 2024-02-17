//
//  BookingCard.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct BookingCard: View {
    
    let booking: BookingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(booking.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 89, height: 150)
                    .clipShape(Rectangle())
                
                VStack(alignment: .leading) {
                    Text(booking.name)
                        .bold()
                        .padding(.bottom, 1)
                    
                    Text("Check out")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 1)
                    
                    Text(formatDate(booking.checkOutDate))
                        .font(.callout)
                        .padding(.bottom, 1)
                    
                    Text("Check in")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 1)
                    
                    Text(formatDate(booking.checkInDate))
                        .font(.callout)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Text(booking.bookingStatus == .ongoing ? "Booking Completed" : "Order Completed")
                            .font(.callout)
                            .foregroundColor(Color(red: 0.08, green: 0.81, blue: 0.45))
                        
                        Spacer()
                        
                        Text(String(format: "%.0f$/Day", booking.price))
                            .bold()
                            .padding(.bottom, 1)
                    }
                    
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 4, y: 10)
                .shadow(color: .black.opacity(0.05), radius: 10, x: -4, y: -10)
            
        )
        .padding(.horizontal)
    }
    
    func formatDate(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyy - h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
    }
}

