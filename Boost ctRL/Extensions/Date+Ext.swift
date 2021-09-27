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
