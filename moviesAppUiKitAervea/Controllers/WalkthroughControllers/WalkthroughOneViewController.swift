//
//  WalkthroughOneViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

class WalkthroughOneViewController: UIViewController {
    //MARK: - Properties
    
    let backgroundImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageOne.getImageName)
        iv.backgroundColor = .systemBlue
        return iv
    }()
    let gradientImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: Constants.WalkthroughImageName.WalkthroughImageOne.getGradient)
        return iv
    }()
    let darckGradientImageView: UIImageView = {
        let iv = UIImageView()
         iv.translatesAutoresizingMaskIntoConstraints = false
         iv.image = UIImage(named: "WalkthroughBlackGradientOne")
        iv.contentMode = .scaleAspectFill
         return iv
     }()
    let frontView = WalkthroughView(frame: .zero, viewModel: .init(type: .first))
    override func viewDidLoad() {
        super.viewDidLoad()
        frontView.delegate = self
        view.backgroundColor = UIColor(named: "bgWV")
        
        view.addSubview(backgroundImage)
        view.addSubview(darckGradientImageView)
        view.addSubview(gradientImageView)
        view.addSubview(frontView)
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: true)
      }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
  
    //MARK: - Private

    private func addConstraints() {
        setupBagraundViewConstraints()
        setupDarckGradientConstraint()
        setupGradientConstraints()
        setupForvardViewConstraints()
    }
    private func setupForvardViewConstraints() {
        NSLayoutConstraint.activate([
            frontView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            frontView.leftAnchor.constraint(equalTo: view.leftAnchor),
            frontView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    private func setupBagraundViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
    private func setupGradientConstraints() {
        NSLayoutConstraint.activate([
            gradientImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientImageView.rightAnchor.constraint(equalTo: view.rightAnchor)

        ])
    }
    private func setupDarckGradientConstraint() {
        NSLayoutConstraint.activate([
            darckGradientImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            darckGradientImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            darckGradientImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            darckGradientImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


//MARK: - extension delegate

extension WalkthroughOneViewController: WalkthroughViewDelegate {
    func didTappedButton() {
        let vc = WalkthroughTwoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
