//
//  Utilities.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

func generateDates() -> [CalendarVO] {
    let cal = NSCalendar.current
    var date = cal.startOfDay(for: Date())
    
    var days = [Date]()
    
    for _ in 1 ... 14 {
        days.append(date)
        date = cal.date(byAdding: .day, value: 1, to: date)!
    }

    let calendars: [CalendarVO] = days.sorted().map { CalendarVO(date: $0) }
    
    return calendars
}

func getToken() -> String {
    guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
        print("No token found")
        return ""
    }
    return token
}

/// Convert double value into "0hr 0min" format
func calculateDuration(_ duration: Double?) -> String {
    guard let duration = duration else {
        return "0hr 0m"
    }
    let hour = Int(duration / 60)
    let minute = Int(Int(duration) % 60)
    return "\(hour)hr \(minute)m"
}
