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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeVC()
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func movieDetail(_ movie: Movie?) {
        let detailVC = MovieDetailVC()
        detailVC.movie = movie
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
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
