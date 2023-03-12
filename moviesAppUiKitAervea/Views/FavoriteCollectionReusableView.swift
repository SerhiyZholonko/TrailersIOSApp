//
//  FavoriteCollectionReusableView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.03.2023.
//

import UIKit

class FavoriteCollectionReusableView: UICollectionReusableView {
    //MARK: - Properties
    static let identifier = "FavoriteCollectionReusableView"
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Favorite".uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}


