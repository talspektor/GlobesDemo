//
//  TabBarController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class TabBarController: UITabBarController, ViewContorllerType {

    static let identifier = String(describing: TabBarController.self)

    private var lastSelection: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userItem = getUsetViewController()
        let soccerItem = getSoccerViewController()

        viewControllers = [userItem, soccerItem]
    }

    private func getUsetViewController() -> UserViewController {
        return TabBarItemsFactory.createTabBarItem(type: UserViewController.self, itemType: .user)
    }

    private func getSoccerViewController() -> SoccerViewController {
        let soccerItem = TabBarItemsFactory.createTabBarItem(type: SoccerViewController.self, itemType: .soccer)
        soccerItem.didSelectCell = { [weak self] lastSelection in
            self?.lastSelection = lastSelection
        }
        return soccerItem
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let viewController = viewController as? UserViewController {
            viewController.viewModel?.lastSelection = lastSelection
        }
        return true
    }
}
