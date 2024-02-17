////
//  Date+Extension.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import Foundation

extension Date {
    // Date -> String
    func string(_ formate: Date.Format, utc: Bool = true) -> String{
        let dateformat = DateFormatter()
        dateformat.dateFormat = formate.rawValue
        if utc {
            dateformat.timeZone = TimeZone(abbreviation: "UTC")
        }
        return dateformat.string(from: self)
    }
    
    static func string(start: Date, end: Date, formate: Date.Format, utc: Bool = false) -> String{
        let start = start.string(formate, utc: utc)
        let end = end.string(formate, utc: utc)
        return "\(start) - \(end)"
    }
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
//        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            return "Just now"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "Min Ago"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "Hr Ago"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "d Ago"
        }
        //        else if secondsAgo < month {
        //                quotient = secondsAgo / week
        //                unit = kWeek
        //            }
        else {
            //            quotient = secondsAgo / month
            //            unit = kMonth
            return self.string(.ddMMMyyyy)
        }
        return "\(quotient) \(unit)"
    }
}

extension Date {
    internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        startOfDay.adjust(.day, offset: 1).adjust(.second, offset: -1)
    }
    
    var weekday: Int {
        return componentDateTool(.weekday)
    }
    
    func componentDateTool(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    var startOfWeek: Date {
        let calendar = Calendar.current
        let date = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return date
    }
    
    var endOfWeek: Date {
        self.startOfWeek.adjust(.day, offset: 6).endOfDay
    }
    
    var startOfMonth: Date {
        self.dateFor(.startOfMonth).startOfDay
    }
    
    var endOfMonth: Date {
        self.dateFor(.endOfMonth).endOfDay
    }
    
    var startOfYear: Date {
        let calender = NSCalendar.init(calendarIdentifier: .gregorian)
        var startOfYear: NSDate?
        var interval = TimeInterval(0)
        calender?.range(of: .year, start: &startOfYear, interval: &interval, for: self)
        return startOfYear! as Date
    }
    
    var day: Int {
        return component(.day)
    }
    
    var weekDayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    var timeString: String {
        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    public enum DateForType {
        case startOfDay, endOfDay, startOfWeek, endOfWeek, startOfMonth, endOfMonth, tomorrow, yesterday, nearestMinute(minute:Int), nearestHour(hour:Int)
    }
    
    func dateFor(_ type: DateForType) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            let offset = dateComponent(.weekday)!-1
            return adjust(.day, offset: -(offset))
        case .endOfWeek:
            let offset = 7 - dateComponent(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            let month = (dateComponent(.month) ?? 0) + 1
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset: 1)
        case .yesterday:
            return adjust(.day, offset: -1)
        case .nearestMinute(let nearest):
            let minutes = (dateComponent(.minute)! + nearest/2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (dateComponent(.hour)! + nearest/2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    
    func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    
    func dateComponent(_ component: DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    
    public enum DateComponentType {
        case second, minute, hour, day, weekday, nthWeekday, week, month, year
    }
    
    func adjust(_ component: DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        switch component {
            case .second:
                dateComp.second = offset
            case .minute:
                dateComp.minute = offset
            case .hour:
                dateComp.hour = offset
            case .day:
                dateComp.day = offset
            case .weekday:
                dateComp.weekday = offset
            case .nthWeekday:
                dateComp.weekdayOrdinal = offset
            case .week:
                dateComp.weekOfYear = offset
            case .month:
                dateComp.month = offset
            case .year:
                dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    static func dates(from fromDate: Date, to toDate: Date, by component: Calendar.Component = .day) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: component, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func dayDifference(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}
