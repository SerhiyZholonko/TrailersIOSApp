//
//  WalkthroughButton.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.01.2023.
//

import UIKit

class WalkthroughButton: UIButton {
    var title: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureButton()
    }
    private func configureButton() {
        
        setTitle(title, for: .normal)
        tintColor = .white
        titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        layer.cornerRadius = 25
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        
    }
}
