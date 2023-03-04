//
//  TrailerCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit

class TrailerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrailerCollectionViewCell"
    let trailerImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let logoImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MAO TRAILER"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let versionLabel: UILabel = {
       let label = UILabel()
        label.text = "V 0.1"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with viewModel: TrailerCollectionViewCellViewModel) {
        trailerImage.image = viewModel.getImage()
    }
    
    //MARK: - private
    private func addSubviews() {
        addSubview(trailerImage)
        addSubview(logoImage)
        addSubview(titleLabel)
        addSubview(versionLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trailerImage.topAnchor.constraint(equalTo: topAnchor),
            trailerImage.leftAnchor.constraint(equalTo: leftAnchor),
            trailerImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailerImage.rightAnchor.constraint(equalTo: rightAnchor),
            
            logoImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 70),
            logoImage.heightAnchor.constraint(equalToConstant: 70),

            titleLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            versionLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 20),
            versionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            
        ])
    }
}
