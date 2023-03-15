//
//  ReviewCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 13.03.2023.
//

import UIKit
import SDWebImage

class ReviewCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "ReviewCollectionViewCell"
    let actorImage: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let usernameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contentLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(actorImage)
        addSubview(contentLabel)
        addSubview(usernameLabel)
        addConstroaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - func
    //Public
    public func configureCell(with viewModel: SingleReviewModel) {
        DispatchQueue.main.async {
            self.contentLabel.text = viewModel.content
            self.usernameLabel.text = viewModel.author
            let url = URL(string: "https://www.themoviedb.org/t/p/original/" + (viewModel.authorDetails?.avatarPath ?? ""))
            self.actorImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    public func configureRateTVShowCell(with viewModel: SingleReviewModel) {
        DispatchQueue.main.async {
            self.contentLabel.text = viewModel.content
            self.usernameLabel.text = viewModel.author
            let url = URL(string: "https://www.themoviedb.org/t/p/original/" + (viewModel.authorDetails?.avatarPath ?? ""))
            self.actorImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    //Private
   private func addConstroaints(){
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            actorImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            actorImage.widthAnchor.constraint(equalToConstant: 40),
            actorImage.heightAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.topAnchor.constraint(equalTo: actorImage.topAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: actorImage.rightAnchor, constant: 10),
            usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            usernameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            contentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            contentLabel.leftAnchor.constraint(equalTo: actorImage.rightAnchor, constant: 5),
            contentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
