//
//  MoviePopularListView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

protocol MoviePopularListViewDelegate: AnyObject {
    func toPopularDetaioViewController(singleMovie: SingleMovie)
}

class MoviePopularListView: UIView {

    var viewModel: MoviePopularListViewModel
    weak var delegate: MoviePopularListViewDelegate?
    private let spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: .large)
        spiner.hidesWhenStopped = true
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collection.register(MoviewsHeaderPopularCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MoviewsHeaderPopularCollectionReusableView.identifier)
        return collection
    }()
    init(frame: CGRect, viewModel: [PopularCollectionViewCellViewModel] ) {
        self.viewModel = MoviePopularListViewModel(nowMovies: viewModel)
        super.init(frame: frame)
        self.viewModel.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        addConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    public func reloadData() {
        collectionView.reloadData()
    }
    //MARK: - Private
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(spiner)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])

    }
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    private func spinerAction() {
        spiner.startAnimating()
    }
}


//MARK: - ex MoviePopularListViewModelDelegate

extension MoviePopularListView: MoviePopularListViewModelDelegate {
    func toDetailView(singleMovie: SingleMovie) {
        delegate?.toPopularDetaioViewController(singleMovie: singleMovie)
    }
    
    
    
    
}
