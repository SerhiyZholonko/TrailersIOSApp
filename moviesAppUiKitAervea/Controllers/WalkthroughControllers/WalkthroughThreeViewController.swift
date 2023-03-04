//
//  WalkthroughThreeViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

class WalkthroughThreeViewController: UIViewController {
    let backgroundImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageThree.getImageName)
        return iv
    }()
    let gradientImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageThree.getGradient)
        return iv
    }()
    let frontView = WalkthroughView(frame: .zero, viewModel: .init(type: .finish))
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

extension WalkthroughThreeViewController: WalkthroughViewDelegate {
    func didTappedButton() {
        
        let vc = MoviesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
