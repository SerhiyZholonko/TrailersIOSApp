//
//  MoreCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

class MoreCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "MoreCollectionViewCell"
    let bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "More".uppercased()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(moreLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leftAnchor.constraint(equalTo: leftAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.rightAnchor.constraint(equalTo: rightAnchor),
            
            moreLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            moreLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            moreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
