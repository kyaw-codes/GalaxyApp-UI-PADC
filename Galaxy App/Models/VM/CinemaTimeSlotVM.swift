//
//  CinemaVM.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

class CinemaTimeSlotVM {
   
    var cinemaID: Int?
    var cinema: String?
    
    var timeslots = [TimeslotVM]()
    
    init(cinemaId: Int?, cinema: String?, timeslots: [Timeslot]?) {
        self.cinemaID = cinemaId
        self.cinema = cinema
        
        timeslots?.forEach { self.timeslots.append($0.getTimeslotVM()) }
    }
}

class TimeslotVM {
    var cinemaDayTimeslotID: Int?
    var startTime: String?
    
    var isSelected = false
    var something: String = ""
    
    init(cinemaDayTimeslotID: Int?, startTime: String?, isSelected: Bool = false) {
        self.cinemaDayTimeslotID = cinemaDayTimeslotID
        self.startTime = startTime
        self.isSelected = isSelected
    }
}
