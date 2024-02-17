//
//  EarningsBreakdown.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct ExpensesBreakdown: View {
    let index: Int
    let earning: Int
    
    let colors = [
        Color(red: 0, green: 0.63, blue: 1),
        Color(red: 1, green: 0.61, blue: 0),
        Color(red: 0.02, green: 0.91, blue: 0.46),
        Color(red: 0.76, green: 0.07, blue: 0.38)
    ]
    
    let labels = [" Booking earnings", " Upcoming earnings", " Reimbursements", " Missed earnings",]
    
    var body: some View {
        HStack(spacing: 16) {
            Ellipse()
                .fill(colors[index])
                .frame(width: 16, height: 16)
            Text("$\(earning)").font(.body.bold()) + Text(labels[index]).foregroundColor(.gray)
            Spacer()
        }
    }
}
