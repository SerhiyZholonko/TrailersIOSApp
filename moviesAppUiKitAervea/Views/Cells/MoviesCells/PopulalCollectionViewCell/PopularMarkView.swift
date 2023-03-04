//
//  PopularMarkView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.02.2023.
//

import UIKit

class PopularMarkView: UIView {
    var viewModel: PopularCollectionViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            DispatchQueue.main.async {
                self.markMaimLabel.text = viewModel.markMain
                self.markSubLabel.text = viewModel.markSup

            }
        }
    }
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    var markMaimLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var markSubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
            super.init(frame: frame)
        addSubview(bgView)
        addSubview(markMaimLabel)
        addSubview(markSubLabel)
        addConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    //MARK: - Public
    public func configure(with viewModel: PopularCollectionViewCellViewModel) {
        print(viewModel.markMain)
        markMaimLabel.text = viewModel.markMain
        markSubLabel.text = viewModel.markSup
    }
        //MARK: - Private
        private func addConstraints() {
            NSLayoutConstraint.activate([
                bgView.topAnchor.constraint(equalTo: topAnchor),
                bgView.leftAnchor.constraint(equalTo: leftAnchor),
                bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
                bgView.rightAnchor.constraint(equalTo: rightAnchor),

                markMaimLabel.topAnchor.constraint(equalTo: topAnchor),
                markMaimLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                markMaimLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: -5),
                markMaimLabel.widthAnchor.constraint(equalToConstant: 25),
                
                markSubLabel.topAnchor.constraint(equalTo: topAnchor),
                markSubLabel.leftAnchor.constraint(equalTo: markMaimLabel.rightAnchor),
                markSubLabel.rightAnchor.constraint(equalTo: rightAnchor),
                markSubLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
                
            ])
        }
    }

