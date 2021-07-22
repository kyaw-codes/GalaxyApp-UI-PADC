//
//  CalendarVM.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

class CalendarVM {
    
    let date: Date
    var isSelected = false
    
    init(date: Date) {
        self.date = date
        isSelected = date.getDay() == Date().getDay()
    }
}
