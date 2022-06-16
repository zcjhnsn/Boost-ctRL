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
    
    func timeAgo(numericDates: Bool = true) -> String {
        let calendar = Calendar.current
        let now = Date.today
        let dateComponents: Set<Calendar.Component> = Set([.minute, .hour, .day, .weekOfYear, .month, .year, .second])
        let components: DateComponents = calendar.dateComponents(dateComponents, from: self, to: now)
        
        if components.year! >= 2 {
            return "\(components.year!)y ago"
        } else if components.year! >= 1 {
            if numericDates {
                return "1y ago"
            } else {
                return "Last year"
            }
        } else if components.month! >= 2 {
            return "\(components.month!)m ago"
        } else if components.month! >= 1 {
            if numericDates {
                return "1m ago"
            } else {
                return "Last month"
            }
        } else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!)w ago"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                return "1w ago"
            } else {
                return "Last week"
            }
        } else if components.day! >= 2 {
            return "\(components.day!)d ago"
        } else if components.day! >= 1 {
            if numericDates {
                return "1d ago"
            } else {
                return "Yesterday"
            }
        } else if components.hour! >= 2 {
            return "\(components.hour!)h ago"
        } else if components.hour! >= 1 {
            if numericDates {
                return "1h ago"
            } else {
                return "An hour ago"
            }
        } else if components.minute! >= 2 {
            return "\(components.minute!)m ago"
        } else if components.minute! >= 1 {
            if numericDates {
                return "1m ago"
            } else {
                return "A minute ago"
            }
        } else if components.second! >= 3 {
            return "\(components.second!)s ago"
        } else {
            return "Just now"
        }
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
