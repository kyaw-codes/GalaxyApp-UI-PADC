//
//  AuthModel.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation
import Alamofire

protocol AuthModel {
    
    func signUpWithEmail(
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (SignUpResponse) -> Void
    )
    
    func signUpWithFb(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (SignUpResponse) -> Void
    )
    
    func signUpWithGoogle(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (SignUpResponse) -> Void
    )
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (SignInResponse) -> Void
    )
    
    func signInWithFacebook(completion: @escaping (SignInResponse) -> Void)
    
    func logOut(completion: @escaping () -> Void)
}

final class AuthModelImpl: BaseModel, AuthModel {
    
    static let shared = AuthModelImpl()
    
    private override init() {
    }
    
    private let userModel = UserModelImpl.shared
    private let cardRepo = CardRepositoryImpl.shared
    
    func signUpWithEmail(name: String, email: String, phone: String, password: String, completion: @escaping (SignUpResponse) -> Void) {
        networkAgent.signUpWithEmail(name: name, email: email, phone: phone, password: password) { [weak self] result in
            do {
                let data = try result.get()
                if let userData = data.data {
                    self?.userModel.save(user: userData)
                    try self?.userModel.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(SignUpResponse(code: data.code, message: data.message, data: signInUserData, token: data.token))
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
    
    func signUpWithFb(vc: UIViewController, name: String, email: String, phone: String, password: String, completion: @escaping (SignUpResponse) -> Void) {
        networkAgent.signUpWithFb(vc: vc, name: name, email: email, phone: phone, password: password) { [weak self] result in
            do {
                let data = try result.get()
                if let userData = data.data {
                    self?.userModel.save(user: userData)
                    try self?.userModel.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(SignUpResponse(code: data.code, message: data.message, data: signInUserData, token: data.token))
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
    
    func signUpWithGoogle(vc: UIViewController, name: String, email: String, phone: String, password: String, completion: @escaping (SignUpResponse) -> Void) {
        networkAgent.signUpWithGoogle(vc: vc, name: name, email: email, phone: phone, password: password) { [weak self] result in
            do {
                let data = try result.get()
                if let userData = data.data {
                    self?.userModel.save(user: userData)
                    try self?.userModel.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(SignUpResponse(code: data.code, message: data.message, data: signInUserData, token: data.token))
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
    
    func signIn(email: String, password: String, completion: @escaping (SignInResponse) -> Void) {
        networkAgent.signIn(email: email, password: password) { [weak self] result in
            do {
                let data = try result.get()
                if let userData = data.data {
                    self?.userModel.save(user: userData)
                    try self?.userModel.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(SignInResponse(code: data.code, message: data.message, data: signInUserData, token: data.token))
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
    
    func signInWithFacebook(completion: @escaping (SignInResponse) -> Void) {
        networkAgent.signInWithFacebook { [weak self] result in
            do {
                let data = try result.get()
                if let userData = data.data {
                    self?.userModel.save(user: userData)
                    try self?.userModel.get(userBy: userData.id ?? -1, completion: { signInUserData in
                        completion(SignInResponse(code: data.code, message: data.message, data: signInUserData, token: data.token))
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
    
    func logOut(completion: @escaping () -> Void) {
        networkAgent.logOut {
            /// Delete the user in the database
            self.userModel.deleteAll()
            
            /// Delete all the cards
            self.cardRepo.deleteAllCards()
            
            /// Remove auth token inside UserDefaults
            UserDefaults.standard.removeObject(forKey: keyAuthToken)
            
            /// Call completion closure
            completion()
        }
    }
}
