////
//  String+Extension.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func toDate(_ formate: Date.Format = .ddMMM, utc: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.Format.iso8601.rawValue
        let date = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = formate.rawValue
        if utc {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}
