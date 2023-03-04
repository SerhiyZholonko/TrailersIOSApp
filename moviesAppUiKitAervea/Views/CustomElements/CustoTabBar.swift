//
//  CustoTabBar.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 13.02.2023.
//

import UIKit

class CustoTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }

    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            let tabBarIndex = tabBarController.selectedIndex
            if tabBarIndex == 0 {
               viewDidLoad()
               
              
            }
        }
}
