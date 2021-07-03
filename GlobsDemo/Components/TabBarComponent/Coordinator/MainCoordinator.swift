//
//  MainCoordinator.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 03/07/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var lastSelection: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators.append(SoccerCoordinator(navigationController: navigationController))
    }

    func start() {
        let tabViewController = TabBarController.instantiate()
        tabViewController.coordinator = self
        setTabBarItems(tabViewController: tabViewController)
        navigationController.pushViewController(tabViewController, animated: false)
    }

    private func setTabBarItems(tabViewController: UITabBarController) {
        let userTab = UserViewController.instantiate()
        userTab.setTabBarItem(itemType: .user)
        setViewModel(userViewController: userTab)

        let soccerTab = SoccerViewController.instantiate()
        soccerTab.coordinator = childCoordinators.first as? SoccerCoordinator
        soccerTab.setTabBarItem(itemType: .soccer)
        soccerTab.didSelectCell = { [weak self] lastSelection in
            self?.lastSelection = lastSelection
        }
        setViewModel(soccerViewContorller: soccerTab)

        tabViewController.viewControllers = [userTab, soccerTab]
    }

    private func setViewModel(userViewController: UserViewController) {
        userViewController.viewModel = UserViewModel()
    }

    private func setViewModel(soccerViewContorller: SoccerViewController) {
        let dataProvider = NetworkSoccesrTeamDataProvider()
        soccerViewContorller.viewModel = SoccerViewModel(dataProvider: dataProvider)
    }
}
