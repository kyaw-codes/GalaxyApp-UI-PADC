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
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "profile"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Craig Federighi", font: .poppinsSemiBold, size: 20, color: .white)
    let mailLabel = UILabel(text: "federighi@apple.com", font: .poppinsRegular, size: 14, color: .white)
    let editButton = UIButton(title: "Edit", font: .poppinsRegular, textSize: 14, textColor: .white)
    lazy var logoutView = createNavItems(#imageLiteral(resourceName: "logout"), title: "Log out")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        addElevation(shouldAdd: false)
        setupView()
        
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogOut)))
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
