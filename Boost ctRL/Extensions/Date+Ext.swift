//
//  Date+Ext.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/23/21.
//

import Foundation

extension Date {
    func dateWithoutTime() -> Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        
        return calendar.date(from: components)!
    }
}


extension Date {
    static var tomorrow: Date { return Date().dayAfter }
    static var today: Date { return Date() }
    var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    func monthsAgo(_ numberOfMonths: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: Date())!
    }
    
    func readable() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .short, timeStyle: .none)
    }
}

extension DateFormatter {
    static let simple: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let isoFrac: ISO8601DateFormatter = {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        
        return isoDateFormatter
    }()
}
