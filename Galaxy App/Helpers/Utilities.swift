//
//  Utilities.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

func generateDates() -> [CalendarVM] {
    let cal = NSCalendar.current
    var date = cal.startOfDay(for: Date())
    
    var days = [Date]()
    
    for _ in 1 ... 3 {
        days.append(date)
        date = cal.date(byAdding: .day, value: -1, to: date)!
    }
    
    date = cal.startOfDay(for: Date())
    
    for _ in 1 ... 7 {
        date = cal.date(byAdding: .day, value: 1, to: date)!
        days.append(date)
    }

    let calendars: [CalendarVM] = days.sorted().map { CalendarVM(date: $0) }
    return calendars
}
