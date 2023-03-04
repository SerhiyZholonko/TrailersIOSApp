//
//  ExtensionUIViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 04.02.2023.
//

import UIKit

extension UIViewController {
    func add(chaildVC: UIViewController, to containerView: UIView) {
           addChild(chaildVC)
          containerView.addSubview(chaildVC.view)
          chaildVC.view.frame = containerView.bounds
          chaildVC.didMove(toParent: self)
      }
    
    func presentAlertViewController(with viewModel: AlertViewModel) {
        DispatchQueue.main.async {
            let alertVC = CustomAletViewController(viewModel: viewModel)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .fullScreen
            self.present(alertVC, animated: true)
        }
    }
    func presentSearchController(complition: @escaping (UIViewController) -> Void){
        DispatchQueue.main.async {
            let searchVC = SearchViewController()
            searchVC.modalTransitionStyle = .crossDissolve
            self.present(searchVC, animated: true)
            complition(searchVC)
        }
    }
}
