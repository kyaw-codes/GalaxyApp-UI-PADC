//
//  SideMenuVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/05/2021.
//

import UIKit

class SideMenuVC: UIViewController {
    
    // MARK: - Properties
    
    let shadowRadius: CGFloat = 16
    var user: SignInUserData? {
        didSet {
            guard let user = user else { return }
            profileImageView.sd_setImage(with: URL(string: "\(baseImageUrl)\(user.profileImage ?? "")"))
            nameLabel.text = user.name
            mailLabel.text = user.email
        }
    }
    
    var onLogoutTapped: (() -> Void)?
    
    // MARK: - Views
    
    private var profileImageView = UIImageView(image: #imageLiteral(resourceName: "profile"), contentMode: .scaleAspectFill)
    private var nameLabel = UILabel(text: "Craig Federighi", font: .poppinsSemiBold, size: 20, color: .white)
    private var mailLabel = UILabel(text: "federighi@apple.com", font: .poppinsRegular, size: 14, color: .white)
    private var editButton = UIButton(title: "Edit", font: .poppinsRegular, textSize: 14, textColor: .white)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        addElevation(shouldAdd: false)
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func createNavItems(_ icon: UIImage, title: String) -> UIStackView {
        let icon = icon.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let imageView = UIImageView(image: icon, contentMode: .scaleAspectFit)
        let label = UILabel(text: title, font: .poppinsRegular, size: 18, color: .white)
        let sv = UIStackView(subViews: [imageView, label, UIView()], axis: .horizontal, spacing: 30)
        return sv
    }
    
    // MARK: - Utility Func
    
    func addElevation(shouldAdd: Bool) {
        if shouldAdd {
            view.layer.shadowColor = UIColor.galaxyViolet.cgColor
            view.layer.shadowOpacity = 0.7
            view.layer.shadowOffset = CGSize(width: 5, height: 0)
            view.layer.shadowRadius = shadowRadius
        } else {
            view.layer.shadowColor = nil
            view.layer.shadowOpacity = 0
        }
    }
    
    // MARK: - Target/Action Method
    
    @objc private func handleLogOut() {
        onLogoutTapped?()        
    }
    
}

// MARK: - Layout Views

extension SideMenuVC {
    
    private func setupView() {
        
        setupProfileView()
        
        // generate nav items
        var navItems: [UIView] = [(#imageLiteral(resourceName: "loyality"), "Promotion code"), (#imageLiteral(resourceName: "translate"), "Select a language"), (#imageLiteral(resourceName: "assignment"), "Term of services"), (#imageLiteral(resourceName: "help"), "Help"), (#imageLiteral(resourceName: "rate"), "Rate us")].map {
            createNavItems($0.0, title: $0.1)
        }
        
        navItems.append(UIView())
        
        let logoutView = createNavItems(#imageLiteral(resourceName: "logout"), title: "Log out")
        navItems.append(logoutView)
        logoutView.isUserInteractionEnabled = true
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogOut)))
        
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
}
