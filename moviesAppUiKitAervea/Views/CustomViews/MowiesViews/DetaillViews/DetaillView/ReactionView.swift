//
//  ReactionView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.02.2023.
//

import UIKit
protocol ReactionViewDalegate: AnyObject {
    func didTappedLike()
    func didTappedComment()
    func didTappedFavorite()
}

class ReactionView: UIView {
    //MARK: - Properties
    weak var delegate: ReactionViewDalegate?
    public let viewModel: ReactionViewModel
    lazy var likeView: LikeReactionSubView = {
        let viewModel = ReactionSubViewModel(imageName: "hand.thumbsup.fill", title: "LIKE", likerMarker: viewModel.pLike, favoriteMarker: viewModel.pFavorite, commentMarker: viewModel.pComment)
        let view = LikeReactionSubView(frame: .zero, viewModel: viewModel)
        return view
    }()
    lazy var favoriteView: FavoriteReactionSubView = {
        let viewModel = ReactionSubViewModel(imageName: "heart.fill", title: "FAVORITE", likerMarker: viewModel.pLike, favoriteMarker: viewModel.pFavorite, commentMarker: viewModel.pComment)
        let view = FavoriteReactionSubView(frame: .zero, viewModel: viewModel)
        return view
    }()
    lazy var comentView:  CommentReactionSubView = {
        let viewModel = ReactionSubViewModel(imageName: "text.bubble", title: "COMMENT", likerMarker: viewModel.pLike, favoriteMarker: viewModel.pFavorite, commentMarker: viewModel.pComment)
        let view = CommentReactionSubView(frame: .zero, viewModel: viewModel)
        return view
    }()
    lazy var reactionStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        likeView,
        favoriteView,
        comentView
       ])
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let bottonView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     init(frame: CGRect, viewModel: ReactionViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        likeView.delegate = self
        comentView.delegate = self
        favoriteView.delegate = self
        addSubview(reactionStack)
        addSubview(bottonView)
        
        addConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstrants() {
        NSLayoutConstraint.activate([
            reactionStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            reactionStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            reactionStack.heightAnchor.constraint(equalToConstant: 60),            reactionStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            bottonView.topAnchor.constraint(equalTo: reactionStack.bottomAnchor),
            bottonView.leftAnchor.constraint(equalTo: leftAnchor),
            bottonView.rightAnchor.constraint(equalTo: rightAnchor),
            bottonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}


extension ReactionView: ReactionSubViewDelegate {
    func didFavorite() {
        print("Favirite")
        delegate?.didTappedFavorite()
    }
    
    func didComment() {
        print("Comment")
        delegate?.didTappedComment()
    }
    
    func didLike() {
        delegate?.didTappedLike()
        print("Like")
    }
    
  
}
