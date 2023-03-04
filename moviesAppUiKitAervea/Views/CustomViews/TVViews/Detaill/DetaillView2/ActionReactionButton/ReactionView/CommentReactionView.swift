//
//  CommentReactionView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class CommentReactionView: UIView {


        //MARK: - Properties
            let commentButton: UIButton = {
                let button = UIButton(type: .system)
                button.setBackgroundImage(UIImage(named: "CommentReaction"), for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
           let commentCounterLabel: UILabel = {
           let label = UILabel()
            label.textColor = .systemGray
            label.text = "390"
               label.textAlignment = .center
               label.translatesAutoresizingMaskIntoConstraints = false
            return label
            }()

        //MARK: - Init
            override init(frame: CGRect) {
                super.init(frame: frame)
                addSubview(commentButton)
                addSubview(commentCounterLabel)
                addConstraints()
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
        //MARK: - Private
            private func addConstraints() {
                NSLayoutConstraint.activate([
                    commentButton.topAnchor.constraint(equalTo: topAnchor),
                    commentButton.leftAnchor.constraint(equalTo: leftAnchor),
                    commentButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    commentButton.rightAnchor.constraint(equalTo: rightAnchor),
                    
                    commentCounterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                    commentCounterLabel.leftAnchor.constraint(equalTo: leftAnchor),
                    commentCounterLabel.rightAnchor.constraint(equalTo: rightAnchor),
                ])
            }

        

}
