//
//  FavoriteReactionSubView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 22.02.2023.
//

import UIKit

class FavoriteReactionSubView : ReactionSubView {

    override init(frame: CGRect, viewModel: ReactionSubViewModel) {
        super.init(frame: frame, viewModel: viewModel)
        reactionButton.addTarget(self, action: #selector(didTappedFavorite), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:  - private
    
    @objc private func didTappedFavorite() {
        viewModel.favoriteButtonPressed()
        delegate?.didFavorite()
    }
    func setupUI() {
        setStatusForFavoriteButton()
        viewModel.viewModelDidChange = { [ weak self ] viewModel in
            self?.setStatusForFavoriteButton()
        }
    }
    private func setStatusForFavoriteButton() {
        DispatchQueue.main.async {
            self.reactionButton.tintColor = self.viewModel.ifFavorite ? .systemPink : .systemGray
        }
    }
}
