////
//  MonthCalendarView.swift
//  bug-free-goggles
//
//  Created by Mac on 16/05/23.
//

import SwiftUI

struct MonthCalendarView: View {
    
    @EnvironmentObject var calendarManager: CalendarManager
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            HStack {
                monthNavigationView
                Spacer(minLength: 0)
                closeButton
            }
            .padding(.bottom)
            
            weekDaysView
            
            CalendarView(interval: .init(start: calendarManager.selectedDate.startOfMonth, end: calendarManager.selectedDate.endOfMonth),
                         showHeaders: false) { date in
            } content: { date in
                Button {
                    withAnimation {
                        calendarManager.selectedDate = date
                    }
                } label: {
                    ZStack {
                        if selectedDateRange.contains(date) {
                            if date == selectedDateRange.lowerBound {
                                RoundedCorners(color: .appPrimary, tl: 8, tr: 0, bl: 8, br: 0)
                                    .matchedGeometryEffect(id: date.weekDayName, in: namespace)
                            } else if date.day == selectedDateRange.upperBound.day {
                                RoundedCorners(color: .appPrimary, tl: 0, tr: 8, bl: 0, br: 8)
                                    .matchedGeometryEffect(id: date.weekDayName, in: namespace)
                            } else {
                                Rectangle()
                                    .fill(Color.appPrimary)
                                    .matchedGeometryEffect(id: date.weekDayName, in: namespace)
                            }
                        }
                        Text("\(date.day)")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(selectedDateRange.contains(date) ? .white : .primary)
                            .transition(.opacity)
                    }
                }
                .foregroundColor(.primary)
                .frame(height: 35, alignment: .center)
            }
            .id(calendarManager.selectedDate)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
    
    private var selectedDateRange: ClosedRange<Date> {
        calendarManager.selectedDate.startOfWeek...calendarManager.selectedDate.endOfWeek
    }
    
    private var dateRange: (start: Date, end: Date) {
        let startDate = calendarManager.selectedDate.startOfMonth
        let endDate = calendarManager.selectedDate.endOfMonth
        return (startDate, endDate)
    }
    
    @ViewBuilder
    private var weekDaysView: some View {
        let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: weekDayNames.count)
        LazyVGrid(columns: columns) {
            ForEach(weekDayNames, id: \.self) { name in
                Text(name)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var weekDayNames: [String] {
        Calendar.current.shortWeekdaySymbols
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image("CloseIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
        }
        
    }
    
    private var monthNavigationView: some View {
        HStack {
            navigateButton(isNext: false)
            selectedWeekText
            navigateButton(isNext: true)
        }
    }
    
    private var selectedWeekText: some View {
        Text(selectedWeekString)
            .font(.system(size: 14, weight: .semibold, design: .default))
    }
    
    private var selectedWeekString: String {
        let startDate = calendarManager.selectedDate.startOfWeek
        let endDate = calendarManager.selectedDate.endOfWeek
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let start = formatter.string(from: startDate)
        let end = formatter.string(from: endDate)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.string(from: startDate)
        
        return "\(start) - \(end), \(year)" // startDate + " - " + endDate + ", " + year
    }
    
    private func navigateButton(isNext: Bool) -> some View {
        Button {
            withAnimation {
                if isNext {
                    calendarManager.selectedDate = calendarManager.selectedDate.adjust(.month, offset: 1).startOfMonth
                } else {
                    calendarManager.selectedDate = calendarManager.selectedDate.adjust(.month, offset: -1).endOfMonth
                }
            }
        } label: {
            Image("arrowBackIcon")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.primary)
                .frame(width: 20, height: 20)
                .padding(5)
        }
        .rotationEffect(.degrees(isNext ? 180 : 0))
    }
}

struct MonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}
