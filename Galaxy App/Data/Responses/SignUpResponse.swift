//
//  SignUpResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import Foundation

// MARK: - SignUpResponse
struct SignUpResponse: Codable {
    let code: Int?
    let message: String?
    let data: SignInUserData?
    let token: String?
}
