////
//  BookNowSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 25/05/23.
//

import SwiftUI

struct BookNowSheet: View {
    @StateObject private var calendarManager = CalendarManager.shared
    @State var adultsCount: Int = 0
    @State var childrenCount: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            MonthCalendarView()
                .environmentObject(calendarManager)
            VStack(spacing: 0) {
                HStack {
                    Text("Guests")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    Button {
                        clearGuests()
                    } label: {
                        Text("Clear")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.appPrimary)
                    }

                }
                .padding(.bottom, 12)
                Divider()
                BookNowItemView(number: $adultsCount, title: "Adults", desc: "after 18")
                    .padding(.vertical, 12)
                Divider()
                BookNowItemView(number: $childrenCount, title: "Children's", desc: "0 - 12 years")
                    .padding(.vertical, 12)
                Divider()
            }
            .padding()
            
            Spacer()
            ImageTextButton(label: "Book Now", image: "bookNowIcon"){

            }
            .padding([.horizontal, .bottom])
        }
        .presentationDetents([.height(620)])
    }
    
    func clearGuests() {
        adultsCount = 0
        childrenCount = 0
    }
}

struct BookNowSheet_Previews: PreviewProvider {
    static var previews: some View {
        BookNowSheet()
    }
}


struct BookNowItemView: View {
    @Binding var number: Int
    let title: String
    let desc: String
    
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                Text(desc)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.secondaryGray)
            }
            Spacer()
            StepperItemView(number: $number)
        }
    }
}


struct StepperItemView: View {
    @Binding var number: Int
    
    var body: some View {
        HStack {
            Button {
                number -= 1
            } label: {
                Text("-")
                    .frame(width: 28, height: 28, alignment: .center)
                    .foregroundColor(number > 0 ? .black : .secondaryGray)
            }
            .disabled(number < 1)
            
            Text(number.description)
            Button {
                number += 1
            } label: {
                Text("+")
                    .frame(width: 28, height: 28, alignment: .center)
            }
        }
        .foregroundColor(.black)
    }
}
