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
        authVC.coordinator = self
        authVC.modalPresentationStyle = .fullScreen
        navigationController.present(authVC, animated: true, completion: nil)
    }
    
    func home() {
        navigationController.dismiss(animated: true, completion: nil)
        let child = HomeCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
