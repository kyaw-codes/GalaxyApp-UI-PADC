//
//  SideMenuVC+layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import UIKit

extension SideMenuVC {
    
    func setupView() {
        
        setupProfileView()
        
        // generate nav items
        var navItems: [UIView] = [(#imageLiteral(resourceName: "loyality"), "Promotion code"), (#imageLiteral(resourceName: "translate"), "Select a language"), (#imageLiteral(resourceName: "assignment"), "Term of services"), (#imageLiteral(resourceName: "help"), "Help"), (#imageLiteral(resourceName: "rate"), "Rate us")].map {
            createNavItems($0.0, title: $0.1)
        }
        
        navItems.append(UIView())
        
        navItems.append(logoutView)
        logoutView.isUserInteractionEnabled = true

        let sv = UIStackView(subViews: navItems, axis: .vertical, spacing: 30)
        view.addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView).inset(10)
            make.top.equalTo(profileImageView.snp.bottom).inset(-50)
            make.trailing.equalTo(editButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    private func setupProfileView() {
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(50)
        }
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.clipsToBounds = true
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).inset(-12)
            make.top.equalTo(profileImageView).inset(-2)
        }
        
        view.addSubview(mailLabel)
        mailLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(profileImageView)
        }
        
        view.addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(mailLabel).inset(-6)
        }
    }
    
    func createNavItems(_ icon: UIImage, title: String) -> UIStackView {
        let icon = icon.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let imageView = UIImageView(image: icon, contentMode: .scaleAspectFit)
        let label = UILabel(text: title, font: .poppinsRegular, size: 18, color: .white)
        let sv = UIStackView(subViews: [imageView, label, UIView()], axis: .horizontal, spacing: 30)
        return sv
    }
}
