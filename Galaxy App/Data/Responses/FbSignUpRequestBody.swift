//
//  FacebookSignUpRequestBody.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import Foundation

struct FbSignUpRequestBody: Codable {
    let name, email, phone, password, id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case phone
        case password
        case id = "facebook-access-token"
    }
}

struct GoogleSignUpRequestBody: Codable {
    let name, email, phone, password, id: String

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case phone
        case password
        case id = "google-access-token"
    }
}
