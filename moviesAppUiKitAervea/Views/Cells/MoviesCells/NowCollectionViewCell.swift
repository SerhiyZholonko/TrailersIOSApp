//
//  NowCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit
import SDWebImage

class NowCollectionViewCell: UICollectionViewCell {
    static let identifier = "NowCollectionViewCell"
    let movieImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.3
        iv.layer.shadowOffset = .init(width: 0, height: 12)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(movieImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
 
    public func configure(with viewModel: NowCollectionViewCellViewModel) {
        print("NowCollectionViewCellViewModel: ", viewModel)
//        viewModel.fetchImage { [weak self] result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    let image = UIImage(data: data)
//                    self?.movieImageView.image = image
//                }
//            case .failure(let error):
//                print(String(describing: error))
//                break
//            }
//        }
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title.uppercased()
            self.movieImageView.dropShadow(cornerRadius: 15)
            guard let url = URL(string: viewModel.urlSring) else { return }
            self.movieImageView.sd_setImage(with: url)
        }

    }
    //MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
    }
}
