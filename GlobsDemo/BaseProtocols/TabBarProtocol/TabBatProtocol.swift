//
//  TabBarItemsFactory.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 03/07/2021.
//

import UIKit

protocol TabBatItemProtocol {
    func setTabBarItem(itemType: ItemBarType)
}

extension TabBatItemProtocol where Self: UIViewController {
    func setTabBarItem(itemType: ItemBarType) {
        tabBarItem = itemType.tabBarItem
    }
}

enum ItemBarType {

    case user
    case soccer
    case globes

    var tabBarItem: UITabBarItem {
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
        case .globes:
            let tabBarItem = UITabBarItem(title: "Gloges",
                                              image: UIImage(systemName: "paperplane.fill"),
                                              selectedImage: UIImage(systemName: "paperplane"))

            return tabBarItem
        }
    }
}
