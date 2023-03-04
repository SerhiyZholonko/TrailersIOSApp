//
//  WalkthroughView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

protocol WalkthroughViewDelegate: AnyObject {
    func didTappedButton()
}

class WalkthroughView: UIView {
    //MARK: - Properties
    
    weak var delegate: WalkthroughViewDelegate?
    var viewModel: WalkthroughViewModel
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    let subInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    let progressImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
   let currentButton: WalkthroughButton = {
        let button = WalkthroughButton(title: "Next")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   //MARK: - Init
    init(frame: CGRect, viewModel: WalkthroughViewModel ) {
       self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(currentButton)

        addSubview(titleLabel)
        addSubview(subInfoLabel)
        addSubview(progressImage)
        addConstaint()
        configere(with: viewModel)
        currentButton.addTarget(self, action: #selector(didTapped), for: .touchUpInside)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func configere(with viewModel: WalkthroughViewModel) {
        titleLabel.text = viewModel.title
        subInfoLabel.text = viewModel.subInfo
        progressImage.image = viewModel.progresImage
        currentButton.setImage(viewModel.buttonImage, for: .normal)
        currentButton.setTitle(viewModel.buttonTitle, for: .normal)
        currentButton.backgroundColor = viewModel.backgroundColor
    }
    private func addConstaint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),

            subInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subInfoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            subInfoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),

            progressImage.topAnchor.constraint(equalTo: subInfoLabel.bottomAnchor, constant: 59),
            progressImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressImage.widthAnchor.constraint(equalToConstant: 90),
            progressImage.heightAnchor.constraint(equalToConstant: 16),
            
            currentButton.topAnchor.constraint(equalTo: progressImage.bottomAnchor, constant: 56),
            currentButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentButton.widthAnchor.constraint(equalToConstant: 192),
            currentButton.heightAnchor.constraint(equalToConstant: 54),
            currentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
    }
    
    @objc  func didTapped() {
        delegate?.didTappedButton()
    }
    
    
}
