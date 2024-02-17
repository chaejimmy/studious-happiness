////
//  Date+Formate.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

extension Date{
    /// Enum representing different date formats.
    enum Format: String {
        /// ISO 8601 format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        /// Standard format: "yyyy-MM-dd HH:mm:ss"
        case standard = "yyyy-MM-dd HH:mm:ss"
        /// Short date format.  ""dd/MM/yyyy"
        case ddMMyyyySlashed = "dd/MM/yyyy"
        /// Short date format.  ""dd MMM, yyyy"
        case ddMMMyyyy = "dd MMM, yyyy"
        /// Short date format.  ""dd MMM"
        case ddMMM = "dd MMM"
        /// Short date format: "MMM d, yyyy"
        case MMMddyyyy = "MMM dd, yyyy"
        /// Short date format: "MMM dd"
        case MMMdd = "MMM dd"
        /// Short date format: "yyyy"
        case yyyy = "yyyy"
        /// Short date format: "dd-mm-yyyy"
        case ddMMyyyydashed = "dd-MM-yyyy"
        /// Short date format: "HH:mm a"
        case hhmma = "hh:mm a"
    }
    
    /// Converts the date to a string using the specified format.
    ///
    /// - Parameter format: The format to use for the string conversion.
    /// - Returns: The string representation of the date.
    func toString(format: Format = .iso8601) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    /// Parses the given string into a `Date` object using the specified format.
    ///
    /// - Parameters:
    ///   - dateString: The string representation of the date.
    ///   - format: The format to use for parsing the date string.
    /// - Returns: A `Date` object parsed from the string, or `nil` if parsing fails.
    static func fromString(_ dateString: String, format: Format = .iso8601) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: dateString)
    }
}

extension Date{
    static func generateDateArray(from startDate: Date, to endDate: Date) -> [Date] {
        let startDate = startDate.startOfDay
        let endDate = endDate.endOfDay
        
        var dates: [Date] = []
        
        // Create a calendar instance
        let calendar = Calendar.current
        
        // Define the range of dates using DateComponents
        let dateComponents = DateComponents(day: 1)
        
        // Start from the startDate and iterate until the endDate
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            
            // Advance to the next date
            currentDate = calendar.date(byAdding: dateComponents, to: currentDate)!
        }
        return dates
    }
}
