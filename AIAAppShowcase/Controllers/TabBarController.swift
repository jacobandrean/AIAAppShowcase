//
//  ViewController.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = StocksViewController()
        let vc2 = ComparisonViewController()
        let vc3 = SettingViewController()
        vc1.title = "Stocks"
        vc2.title = "Comparison"
        vc3.title = "Setting"
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav1.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "stocks"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Comparison", image: UIImage(named: "comparison"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 3)
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }


}

