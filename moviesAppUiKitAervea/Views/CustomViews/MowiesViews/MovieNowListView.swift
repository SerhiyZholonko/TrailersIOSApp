//
//  MovieNowListView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

protocol MovieNowListViewDelegate: AnyObject {
    func toDetailView(singleMovie: NowSingleMovie)
}

class MovieNowListView: UIView {

    var viewModel: MovieNowListViewModel
    weak var delegate: MovieNowListViewDelegate?
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
        collection.register(NowCollectionViewCell.self, forCellWithReuseIdentifier: NowCollectionViewCell.identifier)
        collection.register(MoviewsHeaderNowCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MoviewsHeaderNowCollectionReusableView.identifier)
        return collection
    }()
    init(frame: CGRect, viewModel: [NowCollectionViewCellViewModel] ) {
        self.viewModel = MovieNowListViewModel(nowMovies: viewModel)
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




//MARK: - ex MovieNowListViewModelDelegate

extension MovieNowListView: MovieNowListViewModelDelegate {
    func toDetailController(singleMovie: NowSingleMovie) {
        delegate?.toDetailView(singleMovie: singleMovie)
    }
    
     
}

