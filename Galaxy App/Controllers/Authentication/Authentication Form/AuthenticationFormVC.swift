//
//  AuthenticationFormVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/06/2021.
//

import UIKit

class AuthenticationFormVC: VerticallyScrollableVC<MainCoordinator> {
    
    // MARK: - Properties
    
    var viewType: ViewControllerType!
    
    var onConfirmTapped: ((MainCoordinator, SignInUserData?) -> Void)?
    
    // MARK: - Views
    
    let nameLabel = UILabel(text: "Full name", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    let phoneLabel = UILabel(text: "Phone no.", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    let emailLabel = UILabel(text: "Email", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    let passwordLabel = UILabel(text: "Password", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    let forgotPasswordLabel = UILabel(text: "Forgot Password ?", font: .poppinsRegular, size: 17, color: .galaxyLightBlack)
    
    lazy var nameOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "Monkey")
        if viewType == .signUp {
            field.textField.becomeFirstResponder()
        }
        return field
    }()
    
    let phoneNoOutlineField = OutlineTextField(placeholder: "0911222333", keyboardType: .phonePad)
    
    lazy var emailOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "LilyJohnson@gmail.com", keyboardType: .emailAddress)
        if viewType == .signIn {
            field.textField.becomeFirstResponder()
        }
        field.textField.returnKeyType = .next
        return field
    }()
    
    let passwordOutlineField: OutlineTextField = {
        let field = OutlineTextField(placeholder: "Something unique")
        field.textField.isSecureTextEntry = true
        return field
    }()
    
    lazy var fbSocialButton = SocialButton(title: viewType == .signIn
                                                    ? "Sign in with facebook"
                                                    : "Sign up with facebook", icon: #imageLiteral(resourceName: "logo_fb"))
    
    lazy var googleSocialButton = SocialButton(title: viewType == .signIn
                                                        ? "Sign in with google"
                                                        : "Sign up with google", icon: #imageLiteral(resourceName: "logo_google"))
    
    let confirmButton = CTAButton(title: "Confirm")
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        [emailOutlineField, passwordOutlineField].forEach { $0.textField.delegate = self }
        
        if viewType == .signUp {
            [nameOutlineField, phoneNoOutlineField].forEach { $0.textField.delegate = self }
        }
        
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
        fbSocialButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFbTapped)))
        googleSocialButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoogleTapped)))
    }
    
    // MARK: - Initializers
    
    init(viewType: ViewControllerType) {
        super.init(nibName: nil, bundle: nil)

        self.viewType = viewType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleConfirmTapped() {
        let email = emailOutlineField.textField.text ?? ""
        let password = passwordOutlineField.textField.text ?? ""
        
        if viewType == .signUp {
            let name = nameOutlineField.textField.text ?? ""
            let phone = phoneNoOutlineField.textField.text ?? ""
            signUp(name: name, email: email, phone: phone, password: password)
        } else {
            login(email: email, password: password)
        }
    }
    
    @objc private func handleFbTapped() {
        guard let coordinator = coordinator else { return }
        
        if viewType == .signUp {
            // Sign up with facebook
            let name = nameOutlineField.textField.text ?? ""
            let phone = phoneNoOutlineField.textField.text ?? ""
            let password = passwordOutlineField.textField.text ?? ""
            let email = emailOutlineField.textField.text ?? ""
            
            NetworkAgentImpl.shared.signUpWithFb(vc: self, name: name, email: email, phone: phone, password: password) { result in
                do {
                    let result = try result.get()
                    coordinator.home(userData: result.data)
                    UserDefaults.standard.setValue(result.token, forKey: keyAuthToken)
                } catch {
                    print("[Error while sign up with facebook] \(error)")
                }
            }
        } else {
            // Sign in with facebook
            NetworkAgentImpl.shared.signInWithFacebook { result in
                do {
                    let result = try result.get()
                    coordinator.home(userData: result.data)
                } catch {
                    print("[Error while sign in with facebook] \(error)")
                }
            }
        }
    }
    
    @objc private func handleGoogleTapped() {
        let name = nameOutlineField.textField.text ?? ""
        let phone = phoneNoOutlineField.textField.text ?? ""
        let password = passwordOutlineField.textField.text ?? ""
        let email = emailOutlineField.textField.text ?? ""
        
        if viewType == .signUp {
            NetworkAgentImpl.shared.signUpWithGoogle(vc: self, name: name, email: email, phone: phone, password: password) { result in
                print("Successful")
                do {
                    let response = try result.get()
                    print("Hi")
                    print(response)
                } catch {
                    print("[Error while sign up with google] \(error)")
                }
            }
        } else {
            // Sign in with google
        }
    }
    
}
