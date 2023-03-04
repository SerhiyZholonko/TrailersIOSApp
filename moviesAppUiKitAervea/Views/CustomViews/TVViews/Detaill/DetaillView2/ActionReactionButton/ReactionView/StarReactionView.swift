//
//  StarReactionView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class StarReactionView: UIView {

    //MARK: - Properties
        let starButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(named: "StarReaction"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
       let starCounterLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.text = "2003"
           label.textAlignment = .center
           label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()

    //MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(starButton)
            addSubview(starCounterLabel)
            addConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    //MARK: - Private
        private func addConstraints() {
            NSLayoutConstraint.activate([
                starButton.topAnchor.constraint(equalTo: topAnchor),
                starButton.leftAnchor.constraint(equalTo: leftAnchor),
                starButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                starButton.rightAnchor.constraint(equalTo: rightAnchor),
                
                starCounterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                starCounterLabel.leftAnchor.constraint(equalTo: leftAnchor),
                starCounterLabel.rightAnchor.constraint(equalTo: rightAnchor),
            ])
        }

    

}
