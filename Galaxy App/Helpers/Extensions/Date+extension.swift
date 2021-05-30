//
//  Date+extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/05/2021.
//

import Foundation

extension Date {

    /// Return date object from text
    /// - Parameter dateString: Date text in ('MM/dd/yyyy') format. eg: Date(dateString: "05/27/2021")
    /// - Returns: Date
    static func of(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        guard let date = formatter.date(from: dateString) else {
            fatalError("Failed to convert given date string \(dateString). Make sure your date format is 'MM/dd/yy'")
        }
        
        return date
    }
    
    func stringValue(in format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
