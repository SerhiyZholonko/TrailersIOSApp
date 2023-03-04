//
//  PeopleCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 04.02.2023.
//

import UIKit
import SDWebImage

class CPeopleCollectionViewCell: UICollectionViewCell {
    let actorImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "ZackSnyder")
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Zack Snyder"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let identifier = "PeopleCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actorImageView)
        addSubview(nameLabel)
     addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    public func configureCell(with cast: Cast) {
        nameLabel.text = cast.name
        let stringUrl = cast.profilePath ?? " "
        let stringURL =  "https://www.themoviedb.org/t/p/original/" + stringUrl
        guard let url = URL(string: stringURL) else { return }
        actorImageView.sd_setImage(with: url)
    }
  
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.leftAnchor.constraint(equalTo: leftAnchor),
            actorImageView.rightAnchor.constraint(equalTo: rightAnchor),
            actorImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            nameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
