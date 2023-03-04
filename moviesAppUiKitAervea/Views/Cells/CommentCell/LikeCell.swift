//
//  File.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.02.2023.
//

import UIKit
import SDWebImage

class LikeCell: UICollectionViewCell {
    let photoImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.backgroundColor = .systemGray6
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let avtorLabel: UILabel = {
       let label = UILabel()
        label.text = "Avtor"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let replyTextLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Set up the reply text label
            addSubview(photoImageView)
        addSubview(avtorLabel)
        addSubview(replyTextLabel)
        
        // Set up constraints for the reply text label
        NSLayoutConstraint.activate([
            
            photoImageView.heightAnchor.constraint(equalToConstant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 30),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            avtorLabel.topAnchor.constraint(equalTo: topAnchor),
            avtorLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant:  5),
            avtorLabel.rightAnchor.constraint(equalTo: rightAnchor),
            avtorLabel.heightAnchor.constraint(equalToConstant: 30),
            
            replyTextLabel.leftAnchor.constraint(equalTo: avtorLabel.leftAnchor),
            replyTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            replyTextLabel.topAnchor.constraint(equalTo: avtorLabel.bottomAnchor, constant: 8),
            replyTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with reply: SingleReviewModel?) {
//        replyTextLabel.text = reply.replyText
        guard let reply = reply else { return }
        avtorLabel.text = reply.author
        replyTextLabel.text = reply.content
        guard let stringURL = reply.authorDetails?.avatarPath else { return }
         let url = URL(string: "https://www.themoviedb.org/t/p/original/" + stringURL)
        photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }

}
