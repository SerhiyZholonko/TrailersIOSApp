//
//  MoreTopListView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

protocol MoreTopListViewDelegate: AnyObject {
    func toDetaillViewControler(singleTVShow: SingleTopShow)
}

class MoreTopListView: UIView {

    var viewModel: MoreTopListViewModel
    
    weak var delegate: MoreTopListViewDelegate?
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
        collection.register(TopTVCollectionViewCell.self, forCellWithReuseIdentifier: TopTVCollectionViewCell.identifier)
        collection.register(MoViewNowListViewUnderCollevtionViewSpiner.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: MoViewNowListViewUnderCollevtionViewSpiner.identifier)
        return collection
    }()
    init(frame: CGRect, viewModel: [RateTVCollectionViewCellModel] ) {
        self.viewModel = MoreTopListViewModel(rateTVShows: viewModel)
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


//MARK: - ex MoreTopListViewModelDelegate

extension MoreTopListView: MoreTopListViewModelDelegate {
    func startSpiner() {
        DispatchQueue.main.async {
            self.spiner.startAnimating()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.collectionView.reloadData()
            self.spiner.stopAnimating()
        }
     

    }

    func toDetaillView(singleTVShow: SingleTopShow) {
        delegate?.toDetaillViewControler(singleTVShow: singleTVShow)
    }
}
