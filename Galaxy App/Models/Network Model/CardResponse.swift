//
//  CardResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/07/2021.
//

import Foundation

struct CardResponse: Codable {
    
    let code: Int
    let message: String
    let data: [Card]
}
