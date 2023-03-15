//
//  SceneDelegate.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
 

            let window = UIWindow(windowScene: windowScene)
//            let viewModel = TopBarViewModel()
            
//            let vc = MoviesViewController(viewModel: viewModel)
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
            
            window.rootViewController = UINavigationController(rootViewController: MainTabViewController())
//            UINavigationController(rootViewController: WalkthroughOneViewController())


//            UINavigationController(rootViewController: CPeopleDetailViewController(viewModel: CPeopleDetailViewControllerModel(actorId: "1083010")))


//            CPeopleController(collectionViewLayout: layout)
            self.window = window
            window.makeKeyAndVisible()
            
        }
        
        
    }



}


