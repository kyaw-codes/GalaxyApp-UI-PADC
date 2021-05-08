//
//  AuthenticationVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

class AuthenticationVC: UIViewController {
    
    // MARK: - Views
    
    var coordinator: MainCoordinator?
    
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
    
    private let topTabBar = TopTabBar()
    private let containerView = UIView(backgroundColor: .clear)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        topTabBar.onTabSelectionChange = { [weak self] tabItem in
            self?.onTabItemChange(tappedItem: tabItem)
        }
        
        setupView()
        add(vc: LoginVC.shared)
        
        LoginVC.shared.onConfirmTapped = { [weak self] in
            self?.handleConfirmTapped()
        }
        SignUpVC.shared.onConfirmTapped = { [weak self] in
            self?.handleConfirmTapped()
        }
    }
    
    private func setupView() {
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        setupTopTabView()
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(topTabBar.snp.bottom).inset(-40)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTopTabView() {
        view.addSubview(topTabBar)
        
        topTabBar.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(-34)
            make.leading.trailing.equalTo(welcomeLabel).inset(4)
            make.height.equalTo(60)
        }
    }
    
    private func add(vc: UIViewController) {
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        containerView.didAddSubview(vc.view)
    }
    
    private func remove(vc: UIViewController) {
        vc.removeFromParent()
        vc.view.removeFromSuperview()
        view.willRemoveSubview(vc.view)
    }
    
    private func onTabItemChange(tappedItem: TopTabBar.TabItem) {
        guard let toView = tappedItem.currentVC.view, let fromView = tappedItem.previousVC.view else { return }
        
        let frame = containerView.frame
        var toViewFrame = frame
        var fromViewFrame = frame
        
        if tappedItem.direction == TopTabBar.TabItem.loginToSignUp {
            toViewFrame = CGRect(x: toView.frame.origin.x + frame.width, y: frame.origin.y, width: toView.frame.width, height: frame.height)
            fromViewFrame = CGRect(x: fromView.frame.origin.x - frame.width, y: frame.origin.y, width: fromView.frame.width, height: frame.height)
        } else {
            toViewFrame = CGRect(x: toView.frame.origin.x - frame.width, y: frame.origin.y, width: toView.frame.width, height: frame.height)
            fromViewFrame = CGRect(x: fromView.frame.origin.x + frame.width, y: frame.origin.y, width: fromView.frame.width, height: frame.height)
        }
        
        toView.frame = toViewFrame
        toView.alpha = 0
        
        self.add(vc: tappedItem.currentVC)
        self.remove(vc: tappedItem.previousVC)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            toView.frame = frame
            fromView.frame = fromViewFrame
            toView.alpha = 1
            fromView.alpha = 0
        }, completion: nil)
    }
    
    private func handleConfirmTapped() {
        coordinator?.home()
    }
    
}

