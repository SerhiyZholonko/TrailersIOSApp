//
//  MoViewNowListViewUnderCollevtionViewSpiner.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 07.03.2023.
//

import UIKit

class  MoViewNowListViewUnderCollevtionViewSpiner: UICollectionReusableView {
        static let identifier = "MoViewNowListViewUnderCollevtionViewSpiner"

    private let spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: .large)
        spiner.color = .label
        spiner.hidesWhenStopped = true
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spiner)
        addConstraints()
        startSpiner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    
    public func addConstraints() {
        NSLayoutConstraint.activate([
            spiner.topAnchor.constraint(equalTo: topAnchor),
            spiner.leftAnchor.constraint(equalTo: leftAnchor),
            spiner.rightAnchor.constraint(equalTo: rightAnchor),
            spiner.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    public func startSpiner() {
        spiner.startAnimating()
        
    }
}
