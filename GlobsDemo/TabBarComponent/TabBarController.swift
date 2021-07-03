//
//  TabBarController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class TabBarController: UITabBarController {

    private var lastSelection: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let userItem = getUsetViewController()
        let userTabBarItem = UITabBarItem(title: "User",
                                          image: UIImage(systemName: "person.fill"),
                                          selectedImage: UIImage(systemName: "person"))
        userItem.tabBarItem = userTabBarItem

        let soccerItem = getSoccerViewController()
        soccerItem.viewModel = SoccerViewModel(dataProvider: NeatworkSoccesrTeamDataProvider())
        let soccerTabBarItem = UITabBarItem(title: "Soccer",
                                            image: UIImage(systemName: "gamecontroller.fill"),
                                            selectedImage: UIImage(systemName: "gamecontroller"))
        soccerItem.tabBarItem = soccerTabBarItem

        viewControllers = [userItem, soccerItem]
    }

    private func getUsetViewController() -> UserViewController {
        let storyboard = UIStoryboard(name: UserViewController.identifier, bundle: nil)
        let userItem =  storyboard.instantiateViewController(identifier: UserViewController.identifier) as! UserViewController
        userItem.viewModel = UserViewModel()
        return userItem
    }

    private func getSoccerViewController() -> SoccerViewController {
        let storyboard = UIStoryboard(name: SoccerViewController.identifier, bundle: nil)
        let soccerItem = storyboard.instantiateViewController(identifier: SoccerViewController.identifier) as! SoccerViewController
        soccerItem.viewModel = SoccerViewModel(dataProvider: NeatworkSoccesrTeamDataProvider())
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
