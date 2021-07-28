//
//  AuthenticationFormVC+layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import UIKit

extension AuthenticationFormVC {
    
    func setupViews() {
        let emailSV = UIStackView(subViews: [emailLabel, emailOutlineField], axis: .vertical, spacing: 4)
        let passwordSV = UIStackView(subViews: [passwordLabel, passwordOutlineField], axis: .vertical, spacing: 4)
        let buttonsSV = UIStackView(subViews: [fbSocialButton, googleSocialButton, confirmButton], axis: .vertical, spacing: 30)

        if viewType == .signIn {
            let forgotPasswordSV = UIStackView(arrangedSubviews: [UIView(), forgotPasswordLabel])
            let inputsSV = UIStackView(subViews: [emailSV, passwordSV, forgotPasswordSV], axis: .vertical, spacing: 40)
            
            contentStackView.addArrangedSubview(inputsSV)
        } else {
            let firstSV = UIStackView(subViews: [nameLabel, nameOutlineField], axis: .vertical, spacing: 4)
            let secondSV = UIStackView(subViews: [phoneLabel, phoneNoOutlineField], axis: .vertical, spacing: 4)
            let inputsSV = UIStackView(subViews: [firstSV, emailSV, secondSV, passwordSV], axis: .vertical, spacing: 40)

            contentStackView.addArrangedSubview(inputsSV)
        }
        
        contentStackView.addArrangedSubview(buttonsSV)
        contentStackView.spacing = 40
    }
}
