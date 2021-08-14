//
//  CardEntity+Extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation

extension CardEntity {
    
    func toCard() -> Card {
        Card(id: Int(id), cardHolder: cardHolder, cardNumber: cardNumber, expirationDate: expirationDate, cardType: cardType)
    }
}
