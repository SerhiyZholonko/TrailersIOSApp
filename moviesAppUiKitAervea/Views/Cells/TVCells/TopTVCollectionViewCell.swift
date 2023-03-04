//
//  NowTVCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit
import SDWebImage

class TopTVCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "NowTVCollectionViewCell"
    
    
    let nowTVImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let nowTVTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title".uppercased()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nowTVImageView)
        addSubview(nowTVTitleLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - funcs
    //MARK: - Public
    public func configureCell(with viewModel: RateTVCollectionViewCellModel) {
            nowTVTitleLabel.text = viewModel.titleTV
        guard let url = URL(string: viewModel.topStringUrl) else { return }
        nowTVImageView.sd_setImage(with: url)
    }
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nowTVImageView.topAnchor.constraint(equalTo: topAnchor),
            nowTVImageView.leftAnchor.constraint(equalTo: leftAnchor),
            nowTVImageView.rightAnchor.constraint(equalTo: rightAnchor),
            nowTVImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            nowTVTitleLabel.topAnchor.constraint(equalTo: nowTVImageView.bottomAnchor),
            nowTVTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nowTVTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nowTVTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
   
}
