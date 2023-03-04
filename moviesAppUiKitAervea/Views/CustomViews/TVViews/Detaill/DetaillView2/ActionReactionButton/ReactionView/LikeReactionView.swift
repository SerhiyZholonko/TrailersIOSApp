//
//  LikeReactionView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class LikeReactionView: UIView {
//MARK: - Properties
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "LikeReaction"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   let likeCounterLabel: UILabel = {
   let label = UILabel()
    label.textColor = .systemGray
    label.text = "230K"
       label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()

//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeButton)
        addSubview(likeCounterLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: topAnchor),
            likeButton.leftAnchor.constraint(equalTo: leftAnchor),
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            likeButton.rightAnchor.constraint(equalTo: rightAnchor),
            
            likeCounterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            likeCounterLabel.leftAnchor.constraint(equalTo: leftAnchor),
            likeCounterLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

}
