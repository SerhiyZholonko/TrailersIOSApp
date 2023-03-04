//
//  ReactionSubView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 22.02.2023.
//

import UIKit

protocol ReactionSubViewDelegate: AnyObject {
    func didComment()
    func didLike()
    func didFavorite()
}

class ReactionSubView: UIView {
    //MARK: - Properties
    var viewModel: ReactionSubViewModel
    weak var delegate: ReactionSubViewDelegate?
    lazy var reactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        return button
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - init
    init(frame: CGRect, viewModel: ReactionSubViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
         addSubview(reactionButton)
         addSubview(titleLabel)
         addConstraints()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            reactionButton.widthAnchor.constraint(equalToConstant: 40),
            reactionButton.heightAnchor.constraint(equalToConstant: 40),
            reactionButton.topAnchor.constraint(equalTo: topAnchor),
            reactionButton.leftAnchor.constraint(equalTo: leftAnchor),
            reactionButton.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 120),
            titleLabel.topAnchor.constraint(equalTo: reactionButton.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func setupData() {
        reactionButton.setImage(UIImage(systemName: viewModel.pImageName), for: .normal)
        titleLabel.text = viewModel.pTitle
    }
    
    //Selector
    @objc private func didTappedButton() {
    }
}
