//
//  CinemaSeatResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

// MARK: - CinemaSeatResponse
struct CinemaSeatResponse: Codable {
    let code: Int?
    let message: String?
    let data: [[Seat]]?
}

// MARK: - Seat
struct Seat: Codable {
    let id: Int?
    let type: TypeEnum?
    let seatName, symbol: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
}

enum TypeEnum: String, Codable {
    case available = "available"
    case space = "space"
    case taken = "taken"
    case text = "text"    
}
