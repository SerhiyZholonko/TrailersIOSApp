//
//  ReviewsViewHeader.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.02.2023.
//

import UIKit

protocol ReviewsViewHeaderDelegate: AnyObject {
    func goToBack()
}

class ReviewsViewHeader: UIView {
    //MARK: - Properties
    weak var delegate: ReviewsViewHeaderDelegate?
    public let viewModel: ReviewsViewHeaderModel
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTappedBack), for: .touchUpInside)
        return button
    }()
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(frame: CGRect, viewModel: ReviewsViewHeaderModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemGray5
        addSubview(reviewsLabel)
        addSubview(backButton)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        reviewsLabel.text = "Reviews(\(viewModel.pReviewsCount))"
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backButton.leftAnchor.constraint(equalTo: leftAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            reviewsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            reviewsLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            reviewsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            reviewsLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    @objc private func didTappedBack() {
        delegate?.goToBack()
    }
}
