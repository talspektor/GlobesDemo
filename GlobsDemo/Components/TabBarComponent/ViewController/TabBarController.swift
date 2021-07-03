//
//  TabBarController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit
import Coordinator

class TabBarController: UITabBarController, Storyboarded, BaseViewController {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let viewController = viewController as? UserViewController {
            viewController.viewModel?.lastSelection = coordinator?.lastSelection
        }
        return true
    }
}
