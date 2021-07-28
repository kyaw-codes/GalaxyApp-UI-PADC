//
//  CinemaResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

// MARK: - CinemaResponse
struct CinemaResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Cinema]?
    
    func getCinemaVM() -> [CinemaTimeSlotVO]? {
        
        data?.map { CinemaTimeSlotVO(cinemaId: $0.cinemaID, cinema: $0.cinema, timeslots: $0.timeslots) }
    }
}

// MARK: - Cinema
struct Cinema: Codable {
    let cinemaID: Int?
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
}

// MARK: - Timeslot
struct Timeslot: Codable {
    let cinemaDayTimeslotID: Int?
    let startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
    
    func getTimeslotVM() -> TimeslotVM {
        return TimeslotVM(cinemaDayTimeslotID: cinemaDayTimeslotID, startTime: startTime)
    }
}
