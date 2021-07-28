//
//  PaymentMethodResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/07/2021.
//

import Foundation

// MARK: - PaymentMethodResponse
struct PaymentMethodResponse: Codable {
    let code: Int?
    let message: String?
    let data: [PaymentMethod]?
}

// MARK: - Datum
struct PaymentMethod: Codable {
    let id: Int?
    let name, description: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
    }
}
