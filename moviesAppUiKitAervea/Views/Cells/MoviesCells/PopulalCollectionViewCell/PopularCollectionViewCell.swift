//
//  PopularCollectionViewCell.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "PopularCollectionViewCell"
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.dropShadow(cornerRadius: 20)
       
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let bgTitleView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var markView: PopularMarkView = {
        let view = PopularMarkView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieImageView)
        addSubview(bgTitleView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(markView)
        addConstarints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    
    public func configure(with viewModel: PopularCollectionViewCellViewModel) {
        print("PopularCollectionViewCellViewModel: ", viewModel)
        guard let url = URL(string: viewModel.urlString) else { return }
        DispatchQueue.main.async {
            self.movieImageView.sd_setImage(with: url)
            self.titleLabel.text = viewModel.title.uppercased()
            self.markView.viewModel = viewModel
            self.yearLabel.text = viewModel.year
        }
    }
    //MARK: - Private
    private func addConstarints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            bgTitleView.leftAnchor.constraint(equalTo: leftAnchor),
            bgTitleView.rightAnchor.constraint(equalTo: rightAnchor),
            bgTitleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            bgTitleView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leftAnchor.constraint(equalTo: movieImageView.leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: -20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            markView.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 20),
            markView.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -20),
            
            yearLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            yearLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            yearLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)

        ])
       

    }
}
