//
//  CheckoutVM.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import UIKit

class GlobalVoucherModel {
    
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
    
    static let instance = GlobalVoucherModel()
    
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
    
    func collectData<ViewController: UIViewController, Value: Codable>(
        of viewController: ViewController?,
        keypath: ReferenceWritableKeyPath<ViewController, Value>
    ) {
        
        guard let viewController = viewController else {
            fatalError("viewController cannot be nil")
        }
        
        switch viewController {
        case is MovieDetailVC:
            guard let data = viewController[keyPath: keypath] as? MovieDetail? else {
                fatalError("Given path \(keypath) cannot be converted into type MovieDetail")
            }
            movieName = data?.originalTitle ?? ""
            movieId = data?.id ?? -1
            duration = "\(data?.runtime ?? 0)m"
            imageUrl = data?.posterPath ?? ""
            
            print(movieName)
        default:
            break
        }
    }
}
