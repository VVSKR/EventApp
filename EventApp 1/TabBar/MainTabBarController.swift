//
//  MainTabBarController.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let session = URLSession()

    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        let allEventsVC = AllEventsVC(networkManager: networkManager)
        allEventsVC.title = "Мероприятия"
        allEventsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        let favoriteEventsVC = FavoriteEventsVC()
        favoriteEventsVC.title = "Избранное"
        favoriteEventsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let searchVC  = SearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
      
        let tabBarList = [allEventsVC, favoriteEventsVC, searchVC,profileVC ]
        viewControllers = tabBarList.map { UINavigationController(rootViewController: $0) }
    }
}
