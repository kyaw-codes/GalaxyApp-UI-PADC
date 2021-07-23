//
//  SnackResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/07/2021.
//

import Foundation

// MARK: - SnackResponse
struct SnackResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Snack]?
}

// MARK: - Snack
struct Snack: Codable {
    let id: Int?
    let name, description: String?
    let price: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case price, image
    }
}
