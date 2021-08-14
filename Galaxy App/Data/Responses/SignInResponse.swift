//
//  SignInResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import Foundation

// MARK: - SignInResponse
struct SignInResponse: Codable {
    let code: Int?
    let message: String?
    let data: SignInUserData?
    let token: String?
}

// MARK: - DataClass
struct SignInUserData: Codable {
    let id: Int?
    let name, email, phone: String?
    let totalExpense: Double?
    let profileImage: String?
    let cards: [Card]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }
}

// MARK: - Card
struct Card: Codable {
    let id: Int?
    let cardHolder, cardNumber, expirationDate, cardType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType
    }
    
    func toCardEntity() -> CardEntity {
        let entity = CardEntity(context: CoreDataStack.shared.context)
        entity.id = Int64(id ?? -1)
        entity.cardHolder = cardHolder
        entity.cardNumber = cardNumber
        entity.expirationDate = expirationDate
        entity.cardType = cardType
        return entity
    }
}
