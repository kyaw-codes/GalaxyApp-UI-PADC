//
//  LoginVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {

    // MARK: - Properties
    
    static var shared = LoginVC()
    
    var onConfirmTapped: (() -> Void)?
    
    private var mainStackViewBottomConstraint: Constraint?

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
    
    private lazy var fbSocialLoginButton: UIButton = {
        let ob = OutlineButton(title: "Sign in with facebook")
        ob.outlineColor = UIColor.galaxyLightBlack.withAlphaComponent(0.5)
        ob.titleColor = .galaxyLightBlack
        ob.titleFont = UIFont.GalaxyFont.poppinsRegular.font(of: 20)
        ob.setImage(#imageLiteral(resourceName: "logo_fb"), for: .normal)
        ob.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width * 0.15)
        ob.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return ob
    }()
    
    private lazy var googleSocialLoginButton: UIButton = {
        let ob = OutlineButton(title: "Sign in with google")
        ob.outlineColor = UIColor.galaxyLightBlack.withAlphaComponent(0.5)
        ob.titleColor = .galaxyLightBlack
        ob.titleFont = UIFont.GalaxyFont.poppinsRegular.font(of: 20)
        ob.setImage(#imageLiteral(resourceName: "logo_google"), for: .normal)
        ob.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width * 0.2)
        ob.titleEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        return ob
    }()
    
    private let confirmButton = CTAButton(title: "Confirm")
    
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
        
        [emailOutlineField, passwordOutlineField]
            .map { $0.textField }
            .forEach { $0.delegate = self }
        
        setupViews()
        
        watchKeyboardNotification()
        
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Helpers
    
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

extension LoginVC {
   
    private func setupViews() {
        let emailSV = UIStackView(subViews: [emailLabel, emailOutlineField], axis: .vertical, spacing: 4)
        let passwordSV = UIStackView(subViews: [passwordLabel, passwordOutlineField], axis: .vertical, spacing: 4)
        let forgotPasswordSV = UIStackView(arrangedSubviews: [UIView(), forgotPasswordLabel])
        
        let inputsSV = UIStackView(subViews: [emailSV, passwordSV, forgotPasswordSV], axis: .vertical, spacing: 40)
        
        [fbSocialLoginButton, googleSocialLoginButton].forEach {
            $0.snp.makeConstraints { (make) in
                make.height.equalTo(56)
            }
        }
        
        let buttonsSV = UIStackView(subViews: [fbSocialLoginButton, googleSocialLoginButton, confirmButton], axis: .vertical, spacing: 30)
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
