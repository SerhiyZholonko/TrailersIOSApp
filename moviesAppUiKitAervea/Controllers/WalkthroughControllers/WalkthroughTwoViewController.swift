//
//  WalkthroughTwoViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

class WalkthroughTwoViewController: UIViewController {
    let backgroundImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageTwo.getImageName)
        return iv
    }()
    let gradientImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageTwo.getGradient)
        return iv
    }()
    let frontView = WalkthroughView(frame: .zero, viewModel: .init(type: .second))
    override func viewDidLoad() {
        super.viewDidLoad()
        frontView.delegate = self
        view.addSubview(backgroundImage)
        view.addSubview(gradientImageView)
        view.addSubview(frontView)
        addConstraints()
    }
  
    private func addConstraints() {
        setupBagraundViewConstraints()
        setupGradientViewConstraint()
        setupForvardViewConstraints()
    }
    
    private func setupBagraundViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupGradientViewConstraint() {
        NSLayoutConstraint.activate([
            gradientImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            gradientImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupForvardViewConstraints() {
        NSLayoutConstraint.activate([
            frontView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            frontView.leftAnchor.constraint(equalTo: view.leftAnchor),
            frontView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}


//MARK: - extension delegate

extension WalkthroughTwoViewController: WalkthroughViewDelegate {
    func didTappedButton() {
        let vc = WalkthroughThreeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
