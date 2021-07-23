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
    var cinemaId: Int = -1
    var cinemaName: String = ""
    var bookingDate: Date = Date()
    var timeslodId: Int = -1
    var seatNumbers: String = ""
    var totalPrice: Double = 0
    var snack = [SnackData]()
    var cardId: Int = -1
    var bookingNo: String = ""
    var row: String = ""
    var startTime: String = ""
    var movieType: String = "2D"
    var duration: String = "0"
    var imageUrl: String = ""
    
    var bookingDateString: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: bookingDate)
        }
    }
    
    var bookingDateForVoucher: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: bookingDate)
        }
    }
    
    var bookingTime: String = ""
    
    static let instance = CheckoutVM()
    
    private init() { }
    
    func clear() {
        movieId = -1
        cinemaId = -1
        bookingDate = Date()
        timeslodId = -1
        seatNumbers = ""
        totalPrice = 0
        snack = [SnackData]()
        cardId = -1
        bookingNo = ""
        row = ""
        startTime = ""
        movieType = "2D"
    }
}
