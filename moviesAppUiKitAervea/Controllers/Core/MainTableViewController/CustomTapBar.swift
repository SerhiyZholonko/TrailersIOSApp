//
//  CustomTapBar.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.03.2023.
//

import UIKit
class CustomTapBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }

    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewDidLoad()
    }
}
