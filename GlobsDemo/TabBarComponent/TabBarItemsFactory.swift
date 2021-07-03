//
//  TabBarItemsFactory.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 03/07/2021.
//

import UIKit

protocol ViewContorllerType {
    static var identifier: String { get }
}

enum ItemType {

    case tabBar
    case user
    case soccer

    var viewContorller: ViewContorllerType {
        switch self {
        case .tabBar:
            let storyboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
            let tabBarController = storyboard.instantiateViewController(identifier: TabBarController.identifier) as! TabBarController
            return tabBarController
        case .soccer:
            let storyboard = UIStoryboard(name: SoccerViewController.identifier, bundle: nil)
            let soccer = storyboard.instantiateViewController(identifier: SoccerViewController.identifier) as! SoccerViewController
            let dataProvider = NetworkSoccesrTeamDataProvider()
            let viewModel = SoccerViewModel(dataProvider: dataProvider)
            soccer.viewModel = viewModel
            soccer.tabBarItem = tabBarItem
            return soccer
        case .user:
            let storyboard = UIStoryboard(name: UserViewController.identifier, bundle: nil)
            let user =  storyboard.instantiateViewController(identifier: UserViewController.identifier) as! UserViewController
            let viewModel = UserViewModel()
            user.viewModel = viewModel
            user.tabBarItem = tabBarItem
            return user
        }
    }

    private var tabBarItem: UITabBarItem? {
        switch self {
        case .soccer:
            let tabBarItem = UITabBarItem(title: "Soccer",
                                          image: UIImage(systemName: "gamecontroller.fill"),
                                          selectedImage: UIImage(systemName: "gamecontroller"))
            return tabBarItem
        case .user:
            let tabBarItem = UITabBarItem(title: "User",
                                              image: UIImage(systemName: "person.fill"),
                                              selectedImage: UIImage(systemName: "person"))

            return tabBarItem
        case .tabBar:
            return nil
        }
    }
}

protocol ItemsFactory {
    static func createTabBarItem<T: ViewContorllerType>(type: T.Type, itemType: ItemType) -> T
}

class TabBarItemsFactory: ItemsFactory {
    static func createTabBarItem<T: ViewContorllerType>(type: T.Type, itemType: ItemType) -> T {
        return itemType.viewContorller as! T
    }
}
