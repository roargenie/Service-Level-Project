//
//  TabbarViewController.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/14.
//

import UIKit


final class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        delegate = self
        UITabBar.appearance().backgroundColor = .white
        tabBar.tintColor = Color.green
        tabBar.barTintColor = .white
        
        let mainVC = UINavigationController(rootViewController: HomeViewController())
        mainVC.navigationBar.tintColor = Color.black
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.navigationBar.tintColor = Color.black
        let friendsVC = UINavigationController(rootViewController: FriendsViewController())
        friendsVC.navigationBar.tintColor = Color.black
        let profileVC = UINavigationController(rootViewController: MySettingViewController())
        profileVC.navigationBar.tintColor = Color.black
        
        self.setViewControllers([mainVC, shopVC, friendsVC, profileVC], animated: true)
        
        if let items = self.tabBar.items {
            items[0].selectedImage = Icon.home
            items[0].image = Icon.homeInactive
            items[0].title = "홈"
            
            items[1].selectedImage = Icon.shop
            items[1].image = Icon.shopInactive
            items[1].title = "새싹샵"
            
            items[2].selectedImage = Icon.friends
            items[2].image = Icon.friendsInactive
            items[2].title = "새싹친구"
            
            items[3].selectedImage = Icon.my
            items[3].image = Icon.myInactive
            items[3].title = "내정보"
        }
    }
}
