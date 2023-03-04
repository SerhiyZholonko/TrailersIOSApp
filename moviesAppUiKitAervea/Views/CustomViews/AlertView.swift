//
//  AlertView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 17.02.2023.
//

import UIKit
protocol AlertViewDelegate: AnyObject {
    func touchedDismiss()
}

class AlertView: UIView {
//MARK: - Properties
    let viewModel: AlertViewModel
    
    weak var delegate: AlertViewDelegate?
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let massageLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(white: 0.8, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didDismissButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - init
     init(frame: CGRect, viewModel: AlertViewModel) {
         self.viewModel = viewModel
         super.init(frame: frame)
         configure()
         setupData()
         addSubviews()
         addConstraints()
         layer.borderColor = UIColor.white.cgColor
         layer.borderWidth = 3
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    @objc private func didDismissButtonTapped() {
        delegate?.touchedDismiss()
    }
    
    private func configure() {
        backgroundColor = .systemPink
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupData() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.viewModel.title
            self.massageLabel.text = self.viewModel.massage
            self.dismissButton.setTitle(self.viewModel.titleButton, for: .normal)
        }
        
    }
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(massageLabel)
        addSubview(dismissButton)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            massageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            massageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            massageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            massageLabel.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -10),
            
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dismissButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            dismissButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            dismissButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25)
        ])
    }
    
 
}
