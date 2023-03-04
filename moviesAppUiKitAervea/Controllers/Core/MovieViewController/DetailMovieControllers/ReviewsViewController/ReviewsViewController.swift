//
//  ReviewsViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.02.2023.
//

import UIKit


class ReviewsViewController: UIViewController {
    //Properties
    public var viewModel: ReviewsViewListModel
    lazy var reviewsView: ReviewsViewHeader = {
        let view = ReviewsViewHeader(frame: .zero, viewModel: ReviewsViewHeaderModel(reviewsCount: "329"))
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
    lazy var contentView: ReviewsView = {
        let view = ReviewsView(frame: .zero, vc: self, viewModel: .init(reviewModel: viewModel.reviewsList))
        return view
    }()
    let sendTextView: UIView = {
        let view = SendTextView()
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
        view.backgroundColor = .systemGray
        view.addSubview(reviewsView)
        view.addSubview(contentView)
        view.addSubview(moviewImageView)
        view.addSubview(sendTextView)
        addConstraints()
        reviewsView.delegate = self
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            reviewsView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            reviewsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            reviewsView.heightAnchor.constraint(equalToConstant: 120),
            
            contentView.topAnchor.constraint(equalTo: reviewsView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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

extension ReviewsViewController: ReviewsViewHeaderDelegate {
    func goToBack() {
        dismiss(animated: true)
    }
    
    
}
