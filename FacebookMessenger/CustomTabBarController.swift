//
//  CustomTabBarController.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 1/3/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsViewController(collectionViewLayout: layout)

        let recentMessagesNavigationController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavigationController.tabBarItem.title = "Recent"
        recentMessagesNavigationController.tabBarItem.image = UIImage(named: "recent")

        let callController = CallsViewController()
        let callsNavigationController = UINavigationController(rootViewController: callController)
        callsNavigationController.tabBarItem.title = "Calls"
        callsNavigationController.tabBarItem.image = UIImage(named: "calls")

        let groupsController = GroupsViewController()
        let groupsNavigationController = UINavigationController(rootViewController: groupsController)
        groupsNavigationController.tabBarItem.title = "Groups"
        groupsNavigationController.tabBarItem.image = UIImage(named: "groups")

        let peopleController = PeopleViewController()
        let peopleNavigationController = UINavigationController(rootViewController: peopleController)
        peopleNavigationController.tabBarItem.title = "People"
        peopleNavigationController.tabBarItem.image = UIImage(named: "people")

        let settingsController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsController)
        settingsNavigationController.tabBarItem.title = "Settings"
        settingsNavigationController.tabBarItem.image = UIImage(named: "settings")
        
        viewControllers = [recentMessagesNavigationController, callsNavigationController, groupsNavigationController, peopleNavigationController, settingsNavigationController]

    }

}
