//
//  AuthenticationVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

class AuthenticationVC: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: MainCoordinator?
    
    // MARK: - Views
    
    private let welcomeLabel: UILabel = {
        let lbl = UILabel(text: "", font: .poppinsSemiBold, size: 28, numberOfLines: 0, color: .galaxyBlack)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6

        let attrString = NSMutableAttributedString(string: "Welcome!\n", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.galaxyLightBlack,
            NSAttributedString.Key.font: UIFont.GalaxyFont.poppinsRegular.font(of: 18)
        ]
        attrString.append(NSAttributedString(string: "Welcome back, login to continue", attributes: attributes))
        lbl.attributedText = attrString
        return lbl
    }()
    
    private lazy var tabBarView = TabBar(coordinator: coordinator)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    private func handleConfirmTapped() {
        coordinator?.home()
    }
    
}

// MARK: - Layout Views

extension AuthenticationVC {
    
    private func setupView() {
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).inset(-32)
        }
    }
}
