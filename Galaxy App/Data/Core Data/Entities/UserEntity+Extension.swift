//
//  UserEntity+Extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation

extension UserEntity {
    
    func toSignInUserData() -> SignInUserData {
        let cardsArr = [Card]()
        cards.map { $0 }
        return SignInUserData(id: Int(id), name: name, email: email, phone: phone, totalExpense: totalExpense, profileImage: profileImage, cards: cardsArr)
    }
}
