//
//  TopTabBar.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

class TopTabBar: UIView {
    
    private let loginLabel: UILabel = UILabel(text: "Login", font: .poppinsSemiBold, size: 18, color: .galaxyViolet, alignment: .center)
    
    private let signUpLabel: UILabel = UILabel(text: "Sign up", font: .poppinsSemiBold, size: 18, color: .galaxyBlack, alignment: .center)
    
    private let underlineView = UIView(backgroundColor: .galaxyViolet)
    
    private var previousSelectedLabel = TabItem.login.rawValue
    
    public enum TabItem: String {
        case login = "Login"
        case signUp = "Sign up"
        
        static let loginToSignUp = "forward"
        static let signUpToLogin = "backward"
        
        var currentVC: UIViewController {
            switch self {
            case .login:
                return LoginVC.shared
            case .signUp:
                return SignUpVC.shared
            }
        }
        
        var previousVC: UIViewController {
            switch self {
            case .login:
                return SignUpVC.shared
            case .signUp:
                return LoginVC.shared
            }
        }
        
        var direction: String {
            switch self {
            case .login:
                return TabItem.signUpToLogin
            case .signUp:
                return TabItem.loginToSignUp
            }
        }
    }
    
    var onTabSelectionChange: ((TopTabBar.TabItem) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [loginLabel, signUpLabel].forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTabItemTapped(_:))))
        }
        
        let sv = UIStackView(arrangedSubviews: [loginLabel, signUpLabel])
        sv.distribution = .fillEqually
        
        addSubview(sv)
        
        sv.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(underlineView)
    }
    
    override func layoutSubviews() {
        underlineView.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width * 0.5)
            make.height.equalTo(5)
            make.leading.bottom.equalToSuperview()
        }
        underlineView.layer.cornerRadius = 5 / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func handleTabItemTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        guard label.text != previousSelectedLabel else { return }
        
        previousSelectedLabel = label.text ?? ""
        
        switch label.text {
        case loginLabel.text:
            animateUnderlineView()
            onTabSelectionChange?(.login)
        case signUpLabel.text:
            animateUnderlineView()
            onTabSelectionChange?(.signUp)
        default:
            fatalError("Invalid tab item")
        }
    }
    
    private func animateUnderlineView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            
            if self.underlineView.transform == .identity {
                self.underlineView.transform = CGAffineTransform(translationX: self.underlineView.frame.width, y: 0)
                self.signUpLabel.textColor = .galaxyViolet
                self.loginLabel.textColor = .galaxyBlack
            } else {
                self.underlineView.transform = .identity
                self.signUpLabel.textColor = .galaxyBlack
                self.loginLabel.textColor = .galaxyViolet
            }
        }, completion: nil)
    }

}
