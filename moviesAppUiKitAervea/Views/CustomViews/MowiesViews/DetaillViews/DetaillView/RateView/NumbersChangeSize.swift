//
//  NumbersChangeSize.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class NumbersChangeSize: UIView {
//MARK: - Parameters
    let colorText: UIColor
   public var rateingDouble: Double

    lazy var bigNumberLabel: UILabel = {
       let label = UILabel()
        let rate = "\(rateingDouble)"
        let marks =  rate.components(separatedBy: ".")
        label.text = marks[0]
        label.textAlignment = .right
        label.textColor = colorText
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var littleNumberLabel: UILabel = {
        let label = UILabel()
        let rate = "\(rateingDouble)"
        let marks =  rate.components(separatedBy: ".")
        label.text =  "." + marks[1]
        label.textAlignment = .left
        label.textColor = colorText
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//MARK: - Init
    init(frame: CGRect, rateing: Double, colorText: UIColor) {
        self.colorText = colorText
        self.rateingDouble = rateing
        super.init(frame: frame)
        addSubview(bigNumberLabel)
        addSubview(littleNumberLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bigNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            bigNumberLabel.leftAnchor.constraint(equalTo: leftAnchor),
            bigNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bigNumberLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            littleNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            littleNumberLabel.leftAnchor.constraint(equalTo: bigNumberLabel.rightAnchor),
            littleNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            littleNumberLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
//MARK: - Public

}
