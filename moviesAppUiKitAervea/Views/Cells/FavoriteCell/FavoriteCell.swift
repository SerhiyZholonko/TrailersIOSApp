//
//  FavoriteCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.03.2023.
//

import UIKit
import SDWebImage

protocol FavoriteCellDelegate: AnyObject {
   func didTapLike(cell: FavoriteCell)
}


final class FavoriteCell: UICollectionViewCell {
    //MARK: - Parameters
    static let identifier = "FavoriteCell"

    weak var delegate: FavoriteCellDelegate?
    var viewModel: FavoriteListViewModel?
    public var movie: CDMovie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.title
            guard let url = URL(string: movie.stringUrl ?? "") else { return }
            movieImageView.sd_setImage(with: url)
        }
    }
    let movieImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemGreen
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(didTappedLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieImageView)
        addSubview(likeButton)
        addSubview(titleLabel)
        addConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func
    
    private func addConstrints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
        
            likeButton.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 20),
            likeButton.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -20),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    @objc private func didTappedLike() {
        delegate?.didTapLike(cell: self)
    }
}
