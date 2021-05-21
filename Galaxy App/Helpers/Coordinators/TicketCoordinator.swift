//
//  TicketCoordinator.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class TicketCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    
    var parentCoordinator: HomeCoordinator?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pickTheaterVC = PickTheaterVC()
        pickTheaterVC.coordinator = self
        navigationController.pushViewController(pickTheaterVC, animated: true)
    }
    
    func popToMovieDetail() {
        navigationController.popViewController(animated: true)
    }
    
}
