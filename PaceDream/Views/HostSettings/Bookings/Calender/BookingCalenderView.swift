//
//  CalenderView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 31/08/2023.
//

import SwiftUI
import UIKit
import FSCalendar

struct BookingCalendarView: View {
    @State var calendarType: CalendarType = .month
    @State var currentDate: Date = Date()
    
    @ObservedObject var bookingVM: BookingsViewModel
    
    var monthRange: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let currentMonth = dateFormatter.string(from: currentDate)
        let lastMonth = dateFormatter.string(from: currentDate.addingTimeInterval(-2000000))
        
        return "\(lastMonth) \t - \t \(currentMonth)"
    }
    
    var timeBookings: [String: [String]]{
        var timeDivisions: [String: [String]] = [:]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h a"
        
        let specificBookings = bookingVM.bookings.filter { booking in
            let results = Calendar.current.compare(booking.checkInDate, to: bookingVM.selectedDate, toGranularity: .day)
            switch results{
                
            case .orderedSame: return true
                
            default: return false
            }
        }
        
        specificBookings.forEach { booking in
            let hourString = formatter.string(from: booking.checkInDate)
            if timeDivisions.contains(where: { key, _ in
                key == hourString
            }){
                timeDivisions[hourString]?.append(booking.bookingDetails)
            } else {
                timeDivisions[hourString] = [booking.bookingDetails]
            }
            
        }
        
        return timeDivisions
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading) {
                VStack(spacing: 0) {
                    VStack (alignment: .center){
                        Text(monthRange)
                            .font(.headline.bold())
                            .padding(.vertical,5)
                        CalendarTypeSelectionView(selectedCalendarType: calendarType){ type in
                            withAnimation(.easeInOut) {
                                calendarType = type
                            }
                        }
                        .padding(.horizontal)
                    }
                    BookingCalendarViewRepresentable(selectedDate: $bookingVM.selectedDate, currentDate: $currentDate, selectedScope: calendarType.type)
                        .padding(.bottom)
                        .frame(height: 300)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(bookingVM.selectedDate.formatted(date:.long, time: .omitted))
                            .bold()
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    ForEach(Array(timeBookings.keys).sorted(by: <), id: \.self){ time in
                        VStack(alignment: .leading) {
                            Text(time)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.bottom, 3)
                            
                            ForEach(timeBookings[time]!, id:\.self){ bookingDetail in
                                Text(bookingDetail)
                                    .padding(.bottom, 2)
                            }
                            
                        }.padding([.bottom, .horizontal])
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue.opacity(0.1))
                )
            }
            .padding()
        }
    }
    
}

struct BookingCalendarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    fileprivate var calendar = FSCalendar()
    @Binding var selectedDate: Date
    @Binding var currentDate: Date
    var selectedScope: FSCalendarScope
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // Added the below code to change calendar appearance
        calendar.appearance.weekdayTextColor = .gray
        calendar.appearance.todayColor = .blue
        calendar.appearance.headerTitleColor = .white
        calendar.scrollDirection = .horizontal
        calendar.clipsToBounds = false
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.scope = selectedScope
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject,
                       FSCalendarDelegate, FSCalendarDataSource {
        var parent: BookingCalendarViewRepresentable
        
        init(_ parent: BookingCalendarViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            parent.currentDate = calendar.currentPage
        }
    }
}
