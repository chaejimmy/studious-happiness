////
//  WeekCalendarView.swift
//  bug-free-goggles
//
//  Created by Mac on 14/05/23.
//

import SwiftUI
import Foundation

class CalendarManager: ObservableObject {
    static let shared = CalendarManager()
    @Published var selectedDate: Date = Date()
    var previousDate: Date = Date()
    
    private init() {}
}

struct WeekCalendarView: View {
    @EnvironmentObject var calendarManager: CalendarManager
    @Namespace private var namespace
    @State private var selectedDay: String = ""
    @State private var dayIndexes: [Int] = []
    
    var body: some View {
        GeometryReader { bounds in
            ZStack(alignment: .bottom) {
                weekNameView
                    .frame(height: 60, alignment: .top)
                WeekCalendarUIView(bounds: CGSize(width: bounds.size.width, height: 30), selectedDate: calendarManager.selectedDate)
                    .frame(width: bounds.size.width, height: 30, alignment: .bottom)
                    .padding(.bottom, 8)
            }
        }
        .onChange(of: calendarManager.selectedDate) { newValue in
            withAnimation(.spring()) {
                selectedDay = weekdayNameFrom(weekdayNumber: newValue.weekday)
            }
        }
        .onAppear {
            let startDate = calendarManager.selectedDate.startOfWeek.startOfDay
            let endDate = calendarManager.selectedDate.endOfWeek
            dayIndexes = Date.dates(from: startDate, to: endDate).map({$0.weekday})
            
            selectedDay = weekdayNameFrom(weekdayNumber: calendarManager.selectedDate.weekday)
        }
    }
    
    @ViewBuilder
    private var weekNameView: some View {
        
        HStack(spacing: 0) {
            ForEach(dayIndexes, id: \.self) { day in
                WeekDayCellView(name: weekdayNameFrom(weekdayNumber: day), selectedDay: selectedDay, namespace: namespace)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    func weekdayNameFrom(weekdayNumber: Int) -> String {
        let calendar = Calendar.current
        return calendar.shortWeekdaySymbols[weekdayNumber - 1]
    }
    
    struct WeekDayCellView: View {
        var name: String
        var selectedDay: String
        var namespace: Namespace.ID
        
        var body: some View {
            VStack {
                Text(name.uppercased())
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(isSelected ? .primary : .secondary)
                    .frame(height: 15)
                
                Spacer(minLength: 0)
                
                if selectedDay == name {
//                    Capsule()
                    Circle()
                        .fill(Color.appPrimary)
//                        .frame(height: 2)
                        .matchedGeometryEffect(id: "Selected day", in: namespace)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 5)
                }
            }
            .background(Color.white.opacity(0.001))
            .onTapGesture {
                handleTap()
            }
        }
        
        var isSelected: Bool {
            selectedDay == name
        }
        
        func handleTap() {
            let calendar = Calendar.current
            guard let index = calendar.shortWeekdaySymbols.firstIndex(of: name) else { return }
            let selectedDate = CalendarManager.shared.selectedDate
            let dates = Date.dates(from: selectedDate.startOfWeek, to: selectedDate.endOfWeek)
            let tappedDate = dates[index]
            CalendarManager.shared.selectedDate = tappedDate
        }
    }
}

struct WeekCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalendarView()
            .environmentObject(CalendarManager.shared)
    }
}
