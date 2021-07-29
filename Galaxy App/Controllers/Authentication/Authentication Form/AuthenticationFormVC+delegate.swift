//
//  AuthenticationFormVC+delegate.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import UIKit

extension AuthenticationFormVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameOutlineField.textField:
            textField.resignFirstResponder()
            phoneNoOutlineField.textField.becomeFirstResponder()
            return false
        case phoneNoOutlineField.textField:
            textField.resignFirstResponder()
            emailOutlineField.textField.becomeFirstResponder()
            return false
        case emailOutlineField.textField:
            textField.resignFirstResponder()
            passwordOutlineField.textField.becomeFirstResponder()
            return false
        default:
            textField.resignFirstResponder()
            return true
        }
    }
}
