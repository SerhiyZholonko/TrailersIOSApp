//
//  MovieListView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit



class MovieListView: UIView {
    public var collectionView: UICollectionView?
    private var viewModel: MovieListViewModel
    var vm = MovieListViewModel()
    private let spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: .large)
        spiner.hidesWhenStopped = true
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()

    init(frame: CGRect, viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addSubview(spiner)
        addConstraints()
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - public
    public func reloadData() {
        collectionView?.reloadData()
    }
    
    //MARK: - private

    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        addConstraintsSpiner()
        addConstaintsCollectionView(form: collectionView)
    }
    private func addConstraintsSpiner() {
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    private func addConstaintsCollectionView(form collectionView: UICollectionView) {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)

        ])
    }
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MoviewsHeaderNowCollectionReusableView.self, forSupplementaryViewOfKind: "Now", withReuseIdentifier: MoviewsHeaderNowCollectionReusableView.identifier)
        collectionView.register(MoviewsHeaderPopularCollectionReusableView.self, forSupplementaryViewOfKind: "Popular", withReuseIdentifier: MoviewsHeaderPopularCollectionReusableView.identifier)
        collectionView.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.identifier)
        collectionView.register(NowCollectionViewCell.self, forCellWithReuseIdentifier: NowCollectionViewCell.identifier)
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.register(MoreCollectionViewCell.self, forCellWithReuseIdentifier: MoreCollectionViewCell.identifier)
        return collectionView
        }
    
    

    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .trailer:
            return viewModel.createTrailerSectionLayout()
        case .now(let test):
            print(test)
            return viewModel.createNowSectionLayout()
        case .popular:
            return viewModel.createPopularSectionLayout()
        }
       
    }
  
}




