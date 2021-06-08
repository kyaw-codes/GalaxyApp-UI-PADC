//
//  AuthenticationFormVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/06/2021.
//

import UIKit

class AuthenticationFormVC: VerticallyScrollableVC<MainCoordinator> {
    
    // MARK: - ViewControllerType
    
    public enum ViewControllerType {
        case signIn
        case signUp
    }
    
    // MARK: - Properties
    
    var viewType: ViewControllerType!
    
    var onConfirmTapped: ((MainCoordinator) -> Void)?
    
    // MARK: - Views
    
    private lazy var firstNameLabel = UILabel(text: "First name", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private lazy var lastNameLabel = UILabel(text: "Last name", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private lazy var emailLabel = UILabel(text: "Email", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private lazy var passwordLabel = UILabel(text: "Password", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    private lazy var forgotPasswordLabel = UILabel(text: "Forgot Password ?", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    
    private lazy var firstNameOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "Monkey")
        if viewType == .signUp {
            field.textField.becomeFirstResponder()
        }
        return field
    }()
    
    private lazy var lastNameOutlineField = OutlineTextField(placeholder: "Kyaw")
    
    private lazy var emailOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "LilyJohnson@gmail.com", keyboardType: .emailAddress)
        if viewType == .signIn {
            field.textField.becomeFirstResponder()
        }
        field.textField.returnKeyType = .next
        return field
    }()
    
    private lazy var passwordOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "Something unique")
        field.textField.isSecureTextEntry = true
        return field
    }()
    
    private lazy var fbSocialButton = SocialButton(title: viewType == .signIn
                                                    ? "Sign in with facebook"
                                                    : "Sign up with facebook", icon: #imageLiteral(resourceName: "logo_fb"))
    
    private lazy var googleSocialButton = SocialButton(title: viewType == .signIn
                                                        ? "Sign in with google"
                                                        : "Sign up with google", icon: #imageLiteral(resourceName: "logo_google"))
    
    private let confirmButton = CTAButton(title: "Confirm")
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        [emailOutlineField, passwordOutlineField].forEach { $0.textField.delegate = self }
        
        if viewType == .signUp {
            [firstNameOutlineField, lastNameOutlineField].forEach { $0.textField.delegate = self }
        }
        
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
    }
    
    init(viewType: ViewControllerType) {
        super.init(nibName: nil, bundle: nil)

        self.viewType = viewType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleConfirmTapped() {
        guard let coordinator = coordinator else { return }
        onConfirmTapped?(coordinator)
    }
    
}

// MARK: - Layout Views

extension AuthenticationFormVC {
    
    private func setupViews() {
        let emailSV = UIStackView(subViews: [emailLabel, emailOutlineField], axis: .vertical, spacing: 4)
        let passwordSV = UIStackView(subViews: [passwordLabel, passwordOutlineField], axis: .vertical, spacing: 4)
        let buttonsSV = UIStackView(subViews: [fbSocialButton, googleSocialButton, confirmButton], axis: .vertical, spacing: 30)

        if viewType == .signIn {
            let forgotPasswordSV = UIStackView(arrangedSubviews: [UIView(), forgotPasswordLabel])
            let inputsSV = UIStackView(subViews: [emailSV, passwordSV, forgotPasswordSV], axis: .vertical, spacing: 40)
            
            contentStackView.addArrangedSubview(inputsSV)
        } else {
            let firstNameSV = UIStackView(subViews: [firstNameLabel, firstNameOutlineField], axis: .vertical, spacing: 4)
            let lastNameSV = UIStackView(subViews: [lastNameLabel, lastNameOutlineField], axis: .vertical, spacing: 4)
            let inputsSV = UIStackView(subViews: [firstNameSV, lastNameSV, emailSV, passwordSV], axis: .vertical, spacing: 40)

            contentStackView.addArrangedSubview(inputsSV)
        }
        
        contentStackView.addArrangedSubview(buttonsSV)
        contentStackView.spacing = 40
    }
}

// MARK: - UITextFieldDelegate

extension AuthenticationFormVC: UITextFieldDelegate {
    
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
