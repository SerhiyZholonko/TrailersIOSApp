//
//  TVView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit

class TVView: UIView {
    //MARK: - Properties
    //MARK: - Public
    public var collectionView: UICollectionView?

    //MARK: - Private
    private let spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: .large)
        spiner.hidesWhenStopped = true
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    let viewModel: TVViewControllerViewModel
    //MARK: - Init
     init(frame: CGRect, viewModel: TVViewControllerViewModel) {
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
    //MARK: - func
    //MARK: - Public
    
    //MARK: - Private
    private func addConstraints() {
        addConstraintsSpiner()
        addConstaintsCollectionView()
    }
    private func addConstraintsSpiner() {
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    private func addConstaintsCollectionView() {
        guard let collectionView = collectionView else { return }
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
        collectionView.register(MoviewsHeaderNowCollectionReusableView.self, forSupplementaryViewOfKind: "Now2", withReuseIdentifier: MoviewsHeaderNowCollectionReusableView.identifier)
        collectionView.register(MoviewsHeaderPopularCollectionReusableView.self, forSupplementaryViewOfKind: "Popular2", withReuseIdentifier: MoviewsHeaderPopularCollectionReusableView.identifier)
        collectionView.register(PopularTVCollectionViewCell.self, forCellWithReuseIdentifier: PopularTVCollectionViewCell.identifier)
        collectionView.register(RateTVCollectionViewCell.self, forCellWithReuseIdentifier: RateTVCollectionViewCell.identifier)
        collectionView.register(MoreCollectionViewCell.self, forCellWithReuseIdentifier: MoreCollectionViewCell.identifier)
        return collectionView
        }
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
      
        case .top:
            return viewModel.createNowSectionLayout()
        case .popular:
            return viewModel.createPopularSectionLayout()
        }
       
    }
}
