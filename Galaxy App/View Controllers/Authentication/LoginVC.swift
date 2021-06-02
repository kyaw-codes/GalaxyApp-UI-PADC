//
//  LoginVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

class LoginVC: VerticallyScrollableVC<MainCoordinator> {

    // MARK: - Properties
    
    static var shared = LoginVC()
    
    var onConfirmTapped: (() -> Void)?
    
    // MARK: - Views
    
    private let emailLabel = UILabel(text: "Email", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let passwordLabel = UILabel(text: "Password", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private let forgotPasswordLabel = UILabel(text: "Forgot Password ?", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)

    private let emailOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "LilyJohnson@gmail.com", keyboardType: .emailAddress)
        field.textField.becomeFirstResponder()
        field.textField.returnKeyType = .next
        return field
    }()
    
    private let passwordOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "Something unique")
        field.textField.isSecureTextEntry = true
        return field
    }()
    
    private lazy var fbSocialLoginButton = SocialButton(title: "Sign in with facebook", icon: #imageLiteral(resourceName: "logo_fb"))
    
    private lazy var googleSocialLoginButton = SocialButton(title: "Sign in with google", icon: #imageLiteral(resourceName: "logo_google"))
    
    private let confirmButton = CTAButton(title: "Confirm")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailOutlineField, passwordOutlineField]
            .map { $0.textField }
            .forEach { $0.delegate = self }
        
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
    }
    
    override func layoutViews(inside contentView: UIStackView) {
        let emailSV = UIStackView(subViews: [emailLabel, emailOutlineField], axis: .vertical, spacing: 4)
        let passwordSV = UIStackView(subViews: [passwordLabel, passwordOutlineField], axis: .vertical, spacing: 4)
        let forgotPasswordSV = UIStackView(arrangedSubviews: [UIView(), forgotPasswordLabel])

        let inputsSV = UIStackView(subViews: [emailSV, passwordSV, forgotPasswordSV], axis: .vertical, spacing: 40)

        [googleSocialLoginButton].forEach {
            $0.snp.makeConstraints { (make) in
                make.height.equalTo(56)
            }
        }

        let buttonsSV = UIStackView(subViews: [fbSocialLoginButton, googleSocialLoginButton, confirmButton], axis: .vertical, spacing: 30)
        
        contentView.spacing = 40
        contentView.addArrangedSubview(inputsSV)
        contentView.addArrangedSubview(buttonsSV)
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleConfirmTapped() {
        onConfirmTapped?()
    }

}

// MARK: - UITextFieldDelegate

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailOutlineField.textField {
            textField.resignFirstResponder()
            passwordOutlineField.textField.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
}
