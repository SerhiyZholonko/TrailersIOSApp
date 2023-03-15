//
//  ReviewsViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.02.2023.
//

import UIKit
import SDWebImage


class ReviewsViewController: UIViewController {
    //MARK: - Properties
    public var viewModel: ReviewsViewListModel
    lazy var reviewsView: ReviewsViewHeader = {
        let view = ReviewsViewHeader(frame: .zero, viewModel: ReviewsViewHeaderModel(reviewsCount: "0"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let moviewImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let sendTextView: UIView = {
        let view = SendTextView()
        view.alpha = 0
        return view
    }()
    //MARK: init
    init(viewModel: ReviewsViewListModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LiveCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        view.backgroundColor = .systemGray
        view.addSubview(reviewsView)
        view.addSubview(collectionView)
        view.addSubview(moviewImageView)
        view.addSubview(sendTextView)
        addConstraints()
        reviewsView.delegate = self
    }
    //Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            reviewsView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            reviewsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            reviewsView.heightAnchor.constraint(equalToConstant: 120),
            
            collectionView.topAnchor.constraint(equalTo: reviewsView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            moviewImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            moviewImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            moviewImageView.widthAnchor.constraint(equalToConstant: 80),
            moviewImageView.heightAnchor.constraint(equalToConstant: 110),
            
            sendTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sendTextView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sendTextView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sendTextView.heightAnchor.constraint(equalToConstant: 100)

        ])
        
    }
    
}



//MARK: - ReviewsViewHeaderDelegate
extension ReviewsViewController: ReviewsViewHeaderDelegate {
    func goToBack() {
        dismiss(animated: true)
    }
    
    
}

//MARK: - ReviewsViewHeaderDelegate
extension ReviewsViewController: ReviewsViewListModelDelegate {
    func getReviews(viewModel: ReviewsViewListModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.reviewsView.reviewsLabel.text = "Reviews(\(viewModel.listCount))"
            
            switch viewModel.type {
                
            case .nowMovie:
                self?.moviewImageView.sd_setImage(with:  URL(string:
                                                               
                                                                "https://www.themoviedb.org/t/p/original/" + (viewModel.nowMovie?.posterPath ?? "")))
            case .popularMovie:
                self?.moviewImageView.sd_setImage(with:  URL(string:
                                                               
                                                                "https://www.themoviedb.org/t/p/original/" + (viewModel.popularMovie?.posterPath ?? "")))
            case .topTVShow:
                self?.moviewImageView.sd_setImage(with:  URL(string:
                                                               
                                                                "https://www.themoviedb.org/t/p/original/" + (viewModel.topTVShow?.posterPath ?? "")))
            case .popularTVShow:
                self?.moviewImageView.sd_setImage(with:  URL(string:
                                                               
                                                                "https://www.themoviedb.org/t/p/original/" + (viewModel.popularTVShow?.posterPath ?? "")))
            }
        }
       
    }
    
    
}

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ReviewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count review: ", viewModel.listCount)
        return viewModel.listCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell  else {fatalError("bed cell ReviewCollectionViewCell")}
        cell.configureCell(with: viewModel.getSingleReviewModel(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    
}
