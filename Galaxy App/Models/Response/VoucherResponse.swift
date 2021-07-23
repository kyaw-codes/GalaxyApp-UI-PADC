//
//  VoucherResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/07/2021.
//

import Foundation

// MARK: - VoucherResponse
struct VoucherResponse: Codable {
    let message: String?
    let data: Voucher?
    let code: Int?
}

// MARK: - DataClass
struct Voucher: Codable {
    let id: Int?
    let bookingNo, row: String?
    let totalSeat, movieID: Int?
    let snacks: [Snack]?
    let seat, total: String?
    let cinemaID: Int?
    let username, bookingDate: String?
    let timeslot: VoucherTimeslot?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case row
        case totalSeat = "total_seat"
        case movieID = "movie_id"
        case snacks, seat, total
        case cinemaID = "cinema_id"
        case username
        case bookingDate = "booking_date"
        case timeslot
    }
}

// MARK: - VoucherTimeslot
struct VoucherTimeslot: Codable {
    let startTime: String?
    let cinemaDayTimeslotID: Int?

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
    }
}

