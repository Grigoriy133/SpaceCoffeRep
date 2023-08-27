//
//  MainUserTabBar.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 29.05.2023.
//

import UIKit


class OwnerTabBar: UITabBarController {
    static var shared = MainUserTabBar()
    let MenuVC = MenuSettingViewController()
    let StatVC = StatisticViewController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    func setupTabBar(){
        self.viewControllers = [StatVC, MenuVC]
        StatVC.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(systemName: "chart.bar.fill"))
        MenuVC.tabBarItem = UITabBarItem(title: "Настройки", image:UIImage(systemName: "keyboard.onehanded.left"), selectedImage: UIImage(systemName: "keyboard.onehanded.left.fill"))
    
    }
}
