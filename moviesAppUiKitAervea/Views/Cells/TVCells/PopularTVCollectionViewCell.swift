//
//  PopularTVCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit
import SDWebImage

class PopularTVCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "PopularTVCollectionViewCell"

    //MARK: - Public
    public var viewModel: PopularTVCollectionViewCellModel?
    //MARK: - Private
    private let tvImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let tvTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title".uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var tvRateView: TvPpularRateView = {
        let view = TvPpularRateView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tvImageView)
        addSubview(tvTitleLabel)
        addSubview(tvRateView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - funcs
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tvImageView.topAnchor.constraint(equalTo: topAnchor),
            tvImageView.leftAnchor.constraint(equalTo: leftAnchor),
            tvImageView.rightAnchor.constraint(equalTo: rightAnchor),
            tvImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            tvTitleLabel.topAnchor.constraint(equalTo: tvImageView.bottomAnchor),
            tvTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            tvTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tvTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            tvRateView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tvRateView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tvRateView.widthAnchor.constraint(equalToConstant: 40),
            tvRateView.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    public func configureCell(with viewModel: PopularTVCollectionViewCellModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tvTitleLabel.text = viewModel.titleTV.uppercased()
            self.tvRateView.viewModel = viewModel
            if viewModel.stringUrlTV != nil {
                guard let url = URL(string: viewModel.stringUrlTV!) else { return }
                self.tvImageView.sd_setImage(with: url)
            } else {
                self.tvImageView.image = UIImage(systemName: "nosign")
            }
        }
       
      

    }
}
