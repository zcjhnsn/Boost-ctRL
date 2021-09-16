//
//  String+Ext.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/22/21.
//

import Foundation

    /// Localized date and time display options
    enum DateTimeOption {
        /// Just the date sytlized with `.medium` `dateStyle`
        case date
        /// Date and time with `.medium dateStyle` and `.short timeStyle`
        case dateTime
        /// Just the time with `.short timeStyle`
        case time
    }
extension String {
    
    
    /// Takes ISO8601 date string and returns a localized time/date depending on the option
    /// - Parameter option: Which part of the date/time string to return as described by `DateTimeOption`
    /// - Returns: Localized date/time `String`
    func dateToLocal(option: DateTimeOption) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        
        switch option {
        case .dateTime:
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
        case .date:
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
        case .time:
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            
        }
        
        // Just in case the date from Octane isn't formatted correctly
        guard let date = dt else {
            switch option {
            case .dateTime:
                return "---"
            case .date:
                return "---"
            case .time:
                return ""
            }
        }
        
        return dateFormatter.string(from: date)
    }
}
