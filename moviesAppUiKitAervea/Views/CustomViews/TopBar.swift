//
//  MovieTopBar.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit

protocol TopBarDelegate: AnyObject {
    func didTappedButton()
}

class TopBar: UIView {
    //MARK: - Properties
    weak var delegate: TopBarDelegate?
    let viewModel: TopBarViewModel
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var barButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - Init
  
    init(frame: CGRect, viewModel: TopBarViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(barButton)
        addConstraints()
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private
    private func configure() {
        titleLabel.text = viewModel.movieTitle
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.rightAnchor.constraint(equalTo: barButton.leftAnchor),
            
        ])
    }
    @objc private func didTappedButton() {
        delegate?.didTappedButton()
        
    }
    
}
