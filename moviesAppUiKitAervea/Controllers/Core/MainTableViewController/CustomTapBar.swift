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
        
        self.delegate = self
    }


}
