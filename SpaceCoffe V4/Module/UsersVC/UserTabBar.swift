//
//  MainUserTabBar.swift
//  SpaceCoffe V3
//
//  Created by Grigoriy Korotaev on 29.05.2023.
//

import UIKit


class MainUserTabBar: UITabBarController {
    static var shared = MainUserTabBar()
    let orderVC = userMainViewController()
    let userDataVC = UsersDataViewController()
    let mapVC = UsersMapViewController()
    let basketVC = UsersBasketViewController()
    let anothersVC = UsersOthersViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    func setupTabBar(){
        self.viewControllers = [orderVC, userDataVC, basketVC, mapVC,  anothersVC]
        orderVC.tabBarItem = UITabBarItem(title: "Заказ", image: UIImage(systemName: "cup.and.saucer"), selectedImage: UIImage(systemName: "cup.and.saucer.fill"))
        userDataVC.tabBarItem = UITabBarItem(title: "Пользователь", image:UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image:UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        basketVC.tabBarItem = UITabBarItem(title: "Корзина", image:UIImage(systemName: "basket"), selectedImage: UIImage(systemName: "basket.fill"))
        orderVC.tabBarItem = UITabBarItem(title: "Заказ", image: UIImage(systemName: "cup.and.saucer"), selectedImage: UIImage(systemName: "cup.and.saucer.fill"))
        basketVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        anothersVC.tabBarItem = UITabBarItem(title: "Прочее", image:UIImage(systemName: "ellipsis.bubble"), selectedImage: UIImage(systemName: "ellipsis.bubble.fill"))
    }
}
