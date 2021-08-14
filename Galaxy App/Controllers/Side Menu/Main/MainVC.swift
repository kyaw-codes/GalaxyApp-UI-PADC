//
//  MainVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/06/2021.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    // MARK: - View Controllers
    
    let homeVC = HomeVC()
    let sideMenuVC = SideMenuVC()
    
    // MARK: - Views
    
    lazy var homeView = homeVC.view
    lazy var sideMenuView = sideMenuVC.view
    lazy var menuWidth: CGFloat = view.frame.width * 0.8
    let spinner = UIActivityIndicatorView(style: .large)

    // MARK: - Properties
    
    var isMenuVisible = false
    var contentLeadingConstraint: Constraint?
    var menuLeadingConstraint: Constraint?
    private let authModel = AuthModelImpl.shared

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet
        
        sideMenuVC.onLogoutTapped = onLogoutTapped
        homeVC.menuButton.addTarget(self, action: #selector(onMenuButtonTapped), for: .touchUpInside)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
        layoutViews()
    }
    
    // MARK: - Target Action Handlers
    
    @objc private func onMenuButtonTapped() {
        toggleSideMenu()
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        // Snap to the nearest
        if recognizer.state == .ended {
            if  isMenuVisible{
                if translation.x < 0 {
                    toggleSideMenu()
                }
            } else {
                if translation.x > view.frame.width * 0.3 {
                    toggleSideMenu()
                } else {
                    UIView.animate(withDuration: 0.5) {
                        self.menuLeadingConstraint?.update(inset: -self.menuWidth)
                        self.contentLeadingConstraint?.update(inset: 0)
                        self.view.layoutIfNeeded()
                    }
                }
            }
            // Early return
            return
        }
        
        if !isMenuVisible && translation.x > 0.0 && translation.x <= menuWidth {
            menuLeadingConstraint?.update(inset: -menuWidth + translation.x)
            contentLeadingConstraint?.update(inset: 0 + translation.x)
        }
        
        if isMenuVisible && translation.x < 0.0 && translation.x >= -menuWidth {
            menuLeadingConstraint?.update(inset: translation.x)
            contentLeadingConstraint?.update(inset: menuWidth + translation.x)
        }
    }
    
    // MARK: - Private Helper
    
    private func toggleSideMenu() {
        if isMenuVisible {
            // Hide the menu
            menuLeadingConstraint?.update(inset: -menuWidth)
            contentLeadingConstraint?.update(inset: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.sideMenuVC.addElevation(shouldAdd: false)
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            // Show the menu
            menuLeadingConstraint?.update(inset: 0)
            contentLeadingConstraint?.update(inset: menuWidth)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.sideMenuVC.addElevation(shouldAdd: true)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        isMenuVisible = !isMenuVisible
    }
    
    private func onLogoutTapped() {
        spinner.startAnimating()
        
        authModel.logOut { [weak self] in
            self?.spinner.stopAnimating()
            self?.homeVC.coordinator?.logOut()
        }
    }
}
