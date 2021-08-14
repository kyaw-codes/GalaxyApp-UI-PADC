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
        
        authModel.signUpWithEmail(name: name, email: email, phone: phone, password: password) { [weak self] response in
            UserDefaults.standard.setValue(response.token, forKey: keyAuthToken)
            self?.onConfirmTapped?(coordinator, response.data)
        }
    }
    
    func login(email: String, password: String) {
        guard let coordinator = coordinator else { return }

        authModel.signIn(email: email, password: password) { [weak self] response in
            UserDefaults.standard.setValue(response.token, forKey: keyAuthToken)
            self?.onConfirmTapped?(coordinator, response.data)
        }
    }
}
