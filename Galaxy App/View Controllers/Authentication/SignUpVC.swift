//
//  SignUpVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit
import SnapKit

class SignUpVC: UIViewController {

    // MARK: - Properties
    
    static var shared = SignUpVC()
    
    var onConfirmTapped: (() -> Void)?
    
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
    
    private lazy var fbSocialSignUpButton: UIButton = {
        let ob = OutlineButton(title: "Sign up with facebook")
        ob.outlineColor = UIColor.galaxyLightBlack.withAlphaComponent(0.5)
        ob.titleColor = .galaxyLightBlack
        ob.titleFont = UIFont.GalaxyFont.poppinsRegular.font(of: 20)
        ob.setImage(#imageLiteral(resourceName: "logo_fb"), for: .normal)
        ob.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width * 0.15)
        ob.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return ob
    }()
    
    private lazy var googleSocialSignUpButton: UIButton = {
        let ob = OutlineButton(title: "Sign up with google")
        ob.outlineColor = UIColor.galaxyLightBlack.withAlphaComponent(0.5)
        ob.titleColor = .galaxyLightBlack
        ob.titleFont = UIFont.GalaxyFont.poppinsRegular.font(of: 20)
        ob.setImage(#imageLiteral(resourceName: "logo_google"), for: .normal)
        ob.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width * 0.2)
        ob.titleEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        return ob
    }()
    
    private let confirmButton = UIButton(title: "Confirm", textSize: 20)
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.keyboardDismissMode = .interactive
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupViews()
        
        watchKeyboardNotification()
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

    private func watchKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        let isKeyboardShowing = notification.name == UIView.keyboardWillShowNotification
        let keyboardRect = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue)?.cgRectValue
        let bottomPadding: CGFloat = 20
        
        let keyboardHeight = (keyboardRect!.height - view.safeAreaInsets.bottom) + bottomPadding
        let bottomInset = isKeyboardShowing ? keyboardHeight : bottomPadding
        
        // Update the stack view bottom constraint
        mainStackViewBottomConstraint?.update(inset: bottomInset)
        
        let animationDuration = ((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber)?.doubleValue
        
        UIView.animate(withDuration: animationDuration ?? 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc private func handleConfirmTapped() {
        onConfirmTapped?()
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
        
        [fbSocialSignUpButton, googleSocialSignUpButton, confirmButton].forEach {
            $0.snp.makeConstraints { (make) in
                make.height.equalTo(56)
            }
        }
        
        let buttonsSV = UIStackView(subViews: [fbSocialSignUpButton, googleSocialSignUpButton, confirmButton], axis: .vertical, spacing: 30)
        let mainSV = UIStackView(subViews: [inputsSV, buttonsSV], axis: .vertical, spacing: 40)

        setupScrollView()
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        setupContainerView(containerView, mainSV)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setupContainerView(_ containerView: UIView, _ mainSV: UIStackView) {
        containerView.addSubview(mainSV)
        mainSV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            mainStackViewBottomConstraint = make.bottom.equalToSuperview().inset(20).constraint
        }
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
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

