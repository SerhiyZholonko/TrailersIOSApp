//
//  LikeReactionSubView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 22.02.2023.
//

import UIKit

class LikeReactionSubView : ReactionSubView {
    override init(frame: CGRect, viewModel: ReactionSubViewModel) {
        super.init(frame: frame, viewModel: viewModel)
        reactionButton.addTarget(self, action: #selector(didTappedLike), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:  - private
    
    @objc private func didTappedLike() {
        viewModel.likeButtonPressed()
        delegate?.didLike()
    }
    func setupUI() {
        setStatusForFavoriteButton()
        viewModel.viewModelDidChange = { [ weak self ] viewModel in
            self?.setStatusForFavoriteButton()
        }
    }
    private func setStatusForFavoriteButton() {
        DispatchQueue.main.async {
            self.reactionButton.tintColor = self.viewModel.ifLike ? .systemPink : .systemGray
        }
    }
}
