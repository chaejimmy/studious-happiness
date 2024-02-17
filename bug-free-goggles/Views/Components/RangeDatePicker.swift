////
//  RangeDatePicker.swift
//  bug-free-goggles
//
//  Created by Mac on 9/4/23.
//

import SwiftUI

struct RangeDatePicker: View {
    
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    var body: some View {
        VStack {
            
            VStack {
                CalendarGridView(startDate: startDate, endDate: endDate, monthOffset: 1)
                    .padding(.vertical, 10)
                
                CalendarGridView( startDate: startDate, endDate: endDate,monthOffset: 2)
                    .padding(.vertical, 10)
            }
            
            Button("Clear Selection") {
                startDate = nil
                endDate = nil
            }
            .font(.headline)
        }
        .padding()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct CalendarGridView: View {
    @State var startDate: Date?
    @State var endDate: Date?
    
    @State private var selectedMonth: Int = 0
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.fixed(30)), count: 7)
    let monthOffset: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                if monthOffset != 2 {
                    Button(action: {
                        previousMonth()
                    }) {
                        Image("keyboard_arrow_left")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Spacer()
                
                Text(monthString(for: monthOffset))
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if monthOffset != 2 {
                    Button(action: {
                        nextMonth()
                    }) {
                        Image("keyboard_arrow_right")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Spacer()
                
            }.padding(.bottom, 10)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                    Text(String(day.prefix(2)))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }.padding(.bottom)
                
                ForEach(getDatesForMonth( monthOffset), id: \.self) { date in
                    DayCellView(date: date, startDate: startDate ?? Date(), endDate: endDate ?? Date(), isSelected: isDateSelected(date))
                        .onTapGesture {
                            selectDate(date)
                        }
                }
            }
        }
        .padding()
    }
    
    private func getDatesForMonth(_ month: Int) -> [Date] {
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        let dateString = "\(currentYear)-\(month)-01"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        
        var dateComponents = DateComponents()
        dateComponents.month = 1
        dateComponents.day = -2
        
        let calendar = Calendar.current
        let endDateee = calendar.date(byAdding: dateComponents, to: date!)
        
        return calendar.generateDates(
            inside: DateInterval(start: date!, end: endDateee!),
            matching: .init(hour: 0, minute: 0, second: 0)
        )
    }
    
    private func isDateSelected(_ date: Date) -> Bool {
        if let startDate = startDate, let endDate = endDate {
            let selectedRange = DateInterval(start: startDate, end: endDate)
            return selectedRange.contains(date)
        } else {
            return false
        }
    }
    
    private func selectDate(_ date: Date) {
        if startDate == nil {
            startDate = date
            endDate = date
        } else if let existingStartDate = startDate, existingStartDate > date {
            startDate = date
        } else if let existingEndDate = endDate, existingEndDate < date {
            endDate = date
        } else {
            startDate = nil
            endDate = nil
        }
    }
    
    
    private func previousMonth() {
        selectedMonth -= 1
    }
    
    private func nextMonth() {
        selectedMonth += 1
    }
    
    private func monthString(for month: Int) -> String {
        let date = calendar.date(byAdding: .month, value: month, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct DayCellView: View {
    let date: Date
    let startDate: Date
    let endDate: Date
    let isSelected: Bool
    
    
    var body: some View {
        let day = calendar.component(.day, from: date)
        let isWeekend = calendar.isDateInWeekend(date)
        let isInRange = date >= startDate && date <= endDate
        let isSelectedStart = calendar.isDate(date, equalTo: startDate, toGranularity: .day)
        let isSelectedEnd = calendar.isDate(date, equalTo: endDate, toGranularity: .day)
        
        return VStack {
            Text("\(day)")
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(isSelected && !isSelectedStart && !isSelectedEnd && isInRange ? .primary : isSelected ? .white :  .primary)
            
                .padding(.vertical, 4)
                .padding(.horizontal, 4)
            //.background(isWeekend ? Color.red.opacity(0.1) : nil)
                .cornerRadius(5)
            
        }.background{
            
            if !isSelectedStart && !isSelectedEnd && isInRange {
                Rectangle().fill(Color.lightGray)
            }else{
                if isSelectedStart != isSelectedEnd {
                    if isSelectedStart {
                        HStack{
                            Spacer()
                            Rectangle().fill(Color.lightGray).frame(width: 15)
                        }
                        
                    }
                    
                    if isSelectedEnd {
                        HStack{
                            
                            Rectangle().fill(Color.lightGray).frame(width: 15)
                            Spacer()
                        }
                    }
                }
                
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelectedStart || isSelectedEnd ? Color.darkIndigo : (isInRange ? Color.gray.opacity(0.5) : Color.clear))
                    .overlay(isSelectedStart ? Circle().fill(Color.blue) : nil)
                    .overlay(isSelectedEnd ? Circle().fill(Color.blue) : nil)
                
                
            }
            
            
        }.padding(0)
    }
    
    
    
    private let calendar = Calendar.current
}



struct RangeDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        RangeDatePicker()
    }
}
