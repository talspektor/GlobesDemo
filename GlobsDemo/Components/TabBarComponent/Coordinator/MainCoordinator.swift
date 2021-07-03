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
        let userTab = getUserTab()
        let soccerTab = getSoccerTab()
        let globesTab = getGlobesTab()

        tabViewController.viewControllers = [userTab, soccerTab, globesTab]
    }

    private func getUserTab() -> UserViewController {
        let userTab = UserViewController.instantiate()
        userTab.setTabBarItem(itemType: .user)
        userTab.viewModel = userTab.getViewModel(type: UserViewModel.self, viewModelType: .user)

        return userTab
    }

    private func getSoccerTab() -> SoccerViewController {
        let soccerTab = SoccerViewController.instantiate()
        soccerTab.coordinator = childCoordinators.first as? SoccerCoordinator
        soccerTab.setTabBarItem(itemType: .soccer)
        soccerTab.viewModel = soccerTab.getViewModel(type: SoccerViewModel.self,
                                                     viewModelType: .soccer(dataProvider: NetworkSoccesrTeamDataProvider()))
        soccerTab.didSelectCell = { [weak self] lastSelection in
            self?.lastSelection = lastSelection
        }
        return soccerTab
    }

    private func getGlobesTab() -> GlobesInfoViewController {
        let globesTab = GlobesInfoViewController.instantiate()
        globesTab.coordinator = childCoordinators.first as? SoccerCoordinator
        globesTab.setTabBarItem(itemType: .globes)
        globesTab.viewModel = globesTab.getViewModel(type: GlobesInfoViewModel.self,
                                                     viewModelType: .globes(dataProvider: GlobesNetworkDataProvider()))
        globesTab.didSelectCell = { [weak self] lastSelection in
            self?.lastSelection = lastSelection
        }
        return globesTab
    }
}
