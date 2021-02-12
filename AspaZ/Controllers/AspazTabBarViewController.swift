//
//  AspazTabBarControllerViewController.swift
//  AspaZ
//
//  Created by Riza on 12/23/20.
//

import UIKit

class AspazTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuVC = UINavigationController(rootViewController: CuisinesViewController())
        menuVC.tabBarItem.image = UIImage(named: "fork")
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.title = "Сүйікті"
        favoritesVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.title = "Профиліңіз"
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        viewControllers = [menuVC, favoritesVC, profileVC]
        
    }
    

    

}
