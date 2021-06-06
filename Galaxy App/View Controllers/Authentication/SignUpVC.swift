//
//  SignUpVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit
import SnapKit

class SignUpVC: VerticallyScrollableVC<MainCoordinator> {

    // MARK: - Properties
    
    static var shared = SignUpVC()
    
    private var mainStackViewBottomConstraint: Constraint?

    // MARK: - Views

    private let firstNameLabel = UILabel(text: "First name", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let lastNameLabel = UILabel(text: "Last name", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let emailLabel = UILabel(text: "Email", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let passwordLabel = UILabel(text: "Password", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let forgotPasswordLabel = UILabel(text: "Forgot Password ?", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    
    private let firstNameOutlineField = OutlineTextField(placeholder: "Monkey")
    private let lastNameOutlineField = OutlineTextField(placeholder: "Kyaw")
    private let emailOutlineField = OutlineTextField(placeholder: "sexyMonkey@gmail.com", keyboardType: .emailAddress)
    private let passwordOutlineField = OutlineTextField(placeholder: "Something unique")
    
    private lazy var fbSocialSignUpButton = SocialButton(title: "Sign up with facebook", icon: #imageLiteral(resourceName: "logo_fb"))
    
    private lazy var googleSocialSignUpButton = SocialButton(title: "Sign up with google", icon: #imageLiteral(resourceName: "logo_google"))
    
    private let confirmButton = CTAButton(title: "Confirm")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupViews()
        
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Helpers
    
    private func setupTextFields() {
        firstNameOutlineField.textField.becomeFirstResponder()
        passwordOutlineField.textField.isSecureTextEntry = true
        
        [firstNameOutlineField, lastNameOutlineField, emailOutlineField, passwordOutlineField]
            .map { $0.textField }
            .forEach { $0.delegate = self }
        
        [firstNameOutlineField, lastNameOutlineField, emailOutlineField]
            .map { $0.textField }
            .forEach { $0.returnKeyType = .next }
    }

    // MARK: - Action Handlers
    
    @objc private func handleConfirmTapped() {
        coordinator?.home()
    }
}

// MARK: - Layout Views

extension SignUpVC {
    
    private func setupViews() {
        let firstNameSV = UIStackView(subViews: [firstNameLabel, firstNameOutlineField], axis: .vertical, spacing: 4)
        let lastNameSV = UIStackView(subViews: [lastNameLabel, lastNameOutlineField], axis: .vertical, spacing: 4)
        let emailSV = UIStackView(subViews: [emailLabel, emailOutlineField], axis: .vertical, spacing: 4)
        let passwordSV = UIStackView(subViews: [passwordLabel, passwordOutlineField], axis: .vertical, spacing: 4)
        
        let inputsSV = UIStackView(subViews: [firstNameSV, lastNameSV, emailSV, passwordSV], axis: .vertical, spacing: 40)
        
        let buttonsSV = UIStackView(subViews: [fbSocialSignUpButton, googleSocialSignUpButton, confirmButton], axis: .vertical, spacing: 30)

        contentStackView.spacing = 40
        contentStackView.addArrangedSubview(inputsSV)
        contentStackView.addArrangedSubview(buttonsSV)
    }
}

// MARK: - UITextFieldDelegate

extension SignUpVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameOutlineField.textField:
            textField.resignFirstResponder()
            lastNameOutlineField.textField.becomeFirstResponder()
            return false
        case lastNameOutlineField.textField:
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

