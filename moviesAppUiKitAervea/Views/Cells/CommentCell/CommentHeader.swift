//
//  File.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.02.2023.
//

import UIKit

class CommentHeader: UICollectionReusableView {
    let photoLabel: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let avtorOfPost: UILabel = {
       let label = UILabel()
        label.text = "Avtor"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let commentTextLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoLabel)
        addSubview(commentTextLabel)
        addSubview(avtorOfPost)
        
        // Set up constraints for the comment text label
        NSLayoutConstraint.activate([
            photoLabel.widthAnchor.constraint(equalToConstant: 40),
            photoLabel.heightAnchor.constraint(equalToConstant: 40),
            photoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            photoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            avtorOfPost.topAnchor.constraint(equalTo: topAnchor),
            avtorOfPost.leftAnchor.constraint(equalTo: photoLabel.rightAnchor, constant: 5),
            avtorOfPost.rightAnchor.constraint(equalTo: rightAnchor),
            avtorOfPost.heightAnchor.constraint(equalToConstant: 30),
            
            commentTextLabel.leftAnchor.constraint(equalTo: avtorOfPost.leftAnchor),
            commentTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            commentTextLabel.topAnchor.constraint(equalTo: avtorOfPost.bottomAnchor, constant: 8),
            commentTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with comment: Comment) {
        commentTextLabel.text = comment.commentText
    }

}
