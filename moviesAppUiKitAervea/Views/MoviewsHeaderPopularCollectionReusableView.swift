//
//  MoviewsHeaderPopularCollectionReusableView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.02.2023.
//

import UIKit

class MoviewsHeaderPopularCollectionReusableView: UICollectionReusableView {
            static let identifier = "MoviewsHeaderPopularCollectionReusableView"
        let titleLabel: UILabel = {
           let label = UILabel()
            label.text = "Popular"
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)
            addConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        //MARK: - Public
        
        public func addConstraints() {
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor),            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            
        }
    }
