//
//  NavigationBarVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/05/2021.
//

import UIKit
import SnapKit

class NavigationBarVC: UIViewController {
    
    private var profileImageView = UIImageView(image: #imageLiteral(resourceName: "profile"), contentMode: .scaleAspectFill)
    private var nameLabel = UILabel(text: "Craig Federighi", font: .poppinsSemiBold, size: 20, color: .white)
    private var mailLabel = UILabel(text: "federighi@apple.com", font: .poppinsRegular, size: 14, color: .white)
    private var editButton = UIButton(title: "Edit", font: .poppinsRegular, textSize: 14, textColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .galaxyViolet
        setupView()
    }
    
    private func setupView() {
        setupProfileView()
        // generate nav items
        var navItems: [UIView] = [(#imageLiteral(resourceName: "loyality"), "Promotion code"), (#imageLiteral(resourceName: "translate"), "Select a language"), (#imageLiteral(resourceName: "assignment"), "Term of services"), (#imageLiteral(resourceName: "help"), "Help"), (#imageLiteral(resourceName: "rate"), "Rate us")].map {
            createNavItems($0.0, title: $0.1)
        }
        
        navItems.append(UIView())
        navItems.append(createNavItems(#imageLiteral(resourceName: "logout"), title: "Log out"))
        
        let sv = UIStackView(subViews: navItems, axis: .vertical, spacing: 30)
        view.addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView).inset(10)
            make.top.equalTo(profileImageView.snp.bottom).inset(-50)
            make.trailing.equalTo(editButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    private func setupProfileView() {
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.leading.equalToSuperview().inset(20)
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
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(mailLabel)
        }
    }

    private func createNavItems(_ icon: UIImage, title: String) -> UIStackView {
        let icon = icon.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let imageView = UIImageView(image: icon, contentMode: .scaleAspectFit)
        let label = UILabel(text: title, font: .poppinsRegular, size: 18, color: .white)
        let sv = UIStackView(subViews: [imageView, label, UIView()], axis: .horizontal, spacing: 30)
        return sv
    }
    
}
