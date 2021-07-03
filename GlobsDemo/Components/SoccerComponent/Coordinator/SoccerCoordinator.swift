//
//  SoccerCoordinator.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 03/07/2021.
//

import UIKit

class SoccerCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
    }

    func showDetails(name: String?, league: String?) {
        let viewController = DetailViewController.instantiate()
        viewController.setText(name: name, league: league)
        navigationController.pushViewController(viewController, animated: true)
    }
}
