//
//  UserModel.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation
import Alamofire

protocol UserModel {
    
    func save(user: SignInUserData)
    func deleteAll()
    func get(userBy id: Int, completion: (SignInUserData) -> Void) throws
    func fetchProfile(completion: @escaping (ProfileResponse) -> Void)
}

final class UserModelImpl: BaseModel, UserModel {
    
    static let shared = UserModelImpl()
    
    private let userRepo = UserRepositoryImpl.shared
    private let cardRepo = CardRepositoryImpl.shared
    
    private override init() {
    }
    
    func save(user: SignInUserData) {
        userRepo.saveUser(user: user)
    }
    
    func deleteAll() {
        userRepo.deleteAllUser()
    }
    
    func get(userBy id: Int, completion: (SignInUserData) -> Void) throws {
        try userRepo.getUser(by: id, completion: completion)
    }
        
    func fetchProfile(completion: @escaping (ProfileResponse) -> Void) {
        networkAgent.fetchProfile { [weak self] result in
            do {
                let profileResponse: ProfileResponse = try result.get()
                
                if let userData: SignInUserData = profileResponse.data {
                    /// Persist cards to user entity
                    userData.cards?.forEach { card in
                        self?.cardRepo.saveCard(card: card)
                    }
                    
                    try self?.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(ProfileResponse(code: profileResponse.code, message: profileResponse.message, data: signInUserData))
                    })
                }
            } catch {
                switch error {
                case is AFError:
                    print("[Network error] \(error)")
                default:
                    print("[CoreData Error] \(error)")
                }
            }
        }
    }
}
