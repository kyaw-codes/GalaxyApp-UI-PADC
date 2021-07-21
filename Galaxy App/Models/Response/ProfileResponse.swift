//
//  ProfileResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let code: Int?
    let message: String?
    let data: SignInUserData?
}
