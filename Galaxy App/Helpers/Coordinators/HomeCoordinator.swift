//
//  HomeCoordinator.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    var loginUser: SignInUserData?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainVC()
        mainVC.homeVC.coordinator = self
        mainVC.homeVC.user = loginUser
        navigationController.pushViewController(mainVC, animated: true)
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func movieDetail(_ id: Int?) {
        let detailVC = MovieDetailVC()
        detailVC.movieId = id ?? -1
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func logOut() {
        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {            
            parentCoordinator?.start()
        }
    }
    
    func popToHome() {
        navigationController.popViewController(animated: true)
    }
    
    func getTicket() {
        let child = TicketCoordinator(navigationController: navigationController)
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
