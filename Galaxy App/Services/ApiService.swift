//
//  ApiService.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 19/07/2021.
//

import Foundation
import Alamofire

struct ApiService {
    
    static let shared = ApiService()
    
    private init() {}
    
    // MARK: - Authentication
    
    func signUpWithEmail(name: String,
                         email: String,
                         phone: String,
                         password: String,
                         completion: @escaping (Result<SignUpResponse, AFError>) -> Void) {
        let body = [
            "name": name,
            "phone": phone,
            "email": email,
            "password": password
        ]
        
        AF.request("\(baseUrl)/api/v1/register", method: .post, parameters: body).responseDecodable(of: SignUpResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let body = ["email": email, "password": password]
        
        AF.request("\(baseUrl)/api/v1/email-login", method: .post, parameters: body).responseDecodable(of: SignInResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchProfile(completion: @escaping(Result<ProfileResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        AF.request("\(baseUrl)/api/v1/profile", headers: [.authorization(bearerToken: token)]).responseDecodable(of: ProfileResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }
    }
    
    func logOut(completion: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request("\(baseUrl)/api/v1/logout", headers: [.authorization(bearerToken: token)]).response { response in
            UserDefaults.standard.removeObject(forKey: keyAuthToken)
            completion()
        }
    }
}
