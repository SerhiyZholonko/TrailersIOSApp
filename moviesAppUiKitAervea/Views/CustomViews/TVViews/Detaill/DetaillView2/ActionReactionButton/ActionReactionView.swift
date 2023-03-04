//
//  ActionReactionView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class ActionReactionView: UIView {

    let likeView: LikeReactionView = {
        let view = LikeReactionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        let starView: StarReactionView = {
            let button = StarReactionView()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        let comentView: CommentReactionView = {
            let button = CommentReactionView()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        lazy var reactionStack: UIStackView = {
           let sv = UIStackView(arrangedSubviews: [
            likeView,
            starView,
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
        override init(frame: CGRect) {
            super.init(frame: frame)
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
                reactionStack.heightAnchor.constraint(equalToConstant: 80),            reactionStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
                bottonView.topAnchor.constraint(equalTo: reactionStack.bottomAnchor),
                bottonView.leftAnchor.constraint(equalTo: leftAnchor),
                bottonView.rightAnchor.constraint(equalTo: rightAnchor),
                bottonView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

}



