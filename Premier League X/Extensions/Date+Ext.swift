//
//  Date+Ext.swift
//  Premier League X
//
//  Created by hady helal on 03/06/2022.
//

import Foundation

extension Date {
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
    
    func hasSame(_ components: [Calendar.Component], as date: Date) -> Bool {
        var sameValidate = false
        for component in components {
           sameValidate = distance(from: date, only: component) == 0
            if sameValidate == false { return false }
        }
        
        return sameValidate
    }
    
}
