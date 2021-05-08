//
//  MainCoordinator.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let getStartedVC = GetStartedVC()
        getStartedVC.coordinator = self
        navigationController.pushViewController(getStartedVC, animated: false)
    }
    
    func login() {
        let authVC = AuthenticationVC()
        authVC.modalPresentationStyle = .fullScreen
        LoginVC.shared.coordinator = self
        SignUpVC.shared.coordinator = self
        navigationController.present(authVC, animated: true, completion: nil)
    }
    
    func home() {
        let homeVC = HomeVC()
        navigationController.dismiss(animated: true) {
            self.navigationController.pushViewController(homeVC, animated: true)
        }
    }
    
}
