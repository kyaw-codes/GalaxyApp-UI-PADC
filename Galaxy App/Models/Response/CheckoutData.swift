//
//  CheckoutData.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

// MARK: - CheckoutData
class CheckoutData: Codable {
    let cinemaDayTimeslotID: Int?
    let row, seatNumber, bookingDate: String?
    let totalPrice, movieID, cardID, cinemaID: Int?
    let snacks: [Snack]?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieID = "movie_id"
        case cardID = "card_id"
        case cinemaID = "cinema_id"
        case snacks
    }
}

// MARK: - Snack
class Snack: Codable {
    let id, quantity: Int?
}
