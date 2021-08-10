//
//  AuthenticationFormVC+helpers.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import UIKit

extension AuthenticationFormVC {
    
    // MARK: - ViewControllerType
    
    public enum ViewControllerType {
        case signIn
        case signUp
    }
    
    // MARK: - Helper Funcs
    
    func signUp(name: String, email: String, phone: String, password: String) {
        guard let coordinator = coordinator else { return }
        
        NetworkAgentImpl.shared.signUpWithEmail(
            name: name,
            email: email,
            phone: phone,
            password: password
        ) { [weak self] result in
            do {
                let response = try result.get()
                let userData = response.data
                UserDefaults.standard.setValue(response.token, forKey: keyAuthToken)
                self?.onConfirmTapped?(coordinator, userData)
            } catch {
                print("[Error while sign up] \(error)")
            }
        }
    }
    
    func login(email: String, password: String) {
        guard let coordinator = coordinator else { return }
        
        NetworkAgentImpl.shared.signIn(email: email, password: password) { [weak self] result in
            do {
                let response = try result.get()
                let userData = response.data
                UserDefaults.standard.setValue(response.token, forKey: keyAuthToken)
                self?.onConfirmTapped?(coordinator, userData)
            } catch {
                fatalError("[Error while sign in] \(error)")
            }
        }
    }
}
