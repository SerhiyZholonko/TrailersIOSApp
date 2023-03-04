//
//  MainTableViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit


final class MainTabViewController: CustomTapBar {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemOrange
        setupTabs()
        tabBar.backgroundColor = .systemBackground

       
    }
    private func setupTabs() {
        let moviesVC = MoviesViewController()
        let tvVC = TVViewController(viewModel: .init(topBarType: TopBarViewModel(type: .tv)))
        let profileVC = FavoriteViewController(viewModel: FavoriteListViewModel())
        let nav1 = UINavigationController(rootViewController: moviesVC)
        let nav2 = UINavigationController(rootViewController: tvVC)
        let nav3 = UINavigationController(rootViewController: profileVC)
        
        nav1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "MOVIES-def"), selectedImage: UIImage(named: "MOVIES-hov"))
        nav2.tabBarItem = UITabBarItem(title: "", image:  UIImage(named: "TV SHOW-def"), selectedImage: UIImage(named: "TV SHOW-hov"))
        nav3.tabBarItem = UITabBarItem(title: "", image:  UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        nav3.title = "Favorite".uppercased()
        

        setViewControllers([ nav1, nav2, nav3], animated: true)
    }
}
