//
//  CheckoutVM.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

class CheckoutVM {
    
    var movieId: Int = -1
    var movieName: String = ""
    var cinemaName: String = ""
    var bookingDate: Date = Date()
    var timeslodId: Int = -1
    var seatNumbers: String = ""
    var totalPrice: Double = 0
    
    var bookingDateString: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: bookingDate)
        }
    }
    var bookingTime: String = ""
    
    static let instance = CheckoutVM()
    
    private init() { }
}
