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
        let profileVC = UINavigationController(rootViewController: MySettingViewController())
        profileVC.navigationBar.tintColor = Color.black
        
        self.setViewControllers([mainVC, profileVC], animated: true)
        
        if let items = self.tabBar.items {
            items[0].selectedImage = Icon.home
            items[0].image = Icon.homeInactive
            items[0].title = "홈"
            
            items[1].selectedImage = Icon.my
            items[1].image = Icon.myInactive
            items[1].title = "내정보"
        }
    }
}
