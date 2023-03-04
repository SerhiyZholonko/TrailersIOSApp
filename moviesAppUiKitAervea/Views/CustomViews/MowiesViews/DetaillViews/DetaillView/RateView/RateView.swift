//
//  RateView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.02.2023.
//

import UIKit

class RateView: UIView {
//MARK: - Properties
    let rate: Double
    lazy var numberOfRate: NumbersChangeSize = {
        let label = NumbersChangeSize(frame: .zero, rateing: rate, colorText: .systemPink)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    let firsStarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let secondStarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let thirdStarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let fourthStarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let fifthStarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var stackStars: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
        fifthStarView,
        fourthStarView,
        thirdStarView,
        secondStarView,
       firsStarView,
       ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var allStuck: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            numberOfRate,
            stackStars
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
//MARK: - Init
     init(frame: CGRect, rate: Double) {
        self.rate = rate
        super.init(frame: frame)
        addSubview(allStuck)
        addConstraints()
        setupeRate(with: rate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public
    public func setupeRate(with model: Double) {
        switch model {
        case 8...10:
            firsStarView.image = UIImage(named: "StarFill")
            secondStarView.image = UIImage(named: "StarFill")
            thirdStarView.image = UIImage(named: "StarFill")
            fourthStarView.image = UIImage(named: "StarFill")
            fifthStarView.image = UIImage(named: "StarFill")
        case 6..<8:
            fifthStarView.image = UIImage(named: "StarFill")
            fourthStarView.image = UIImage(named: "StarFill")
            thirdStarView.image = UIImage(named: "StarFill")
            secondStarView.image = UIImage(named: "StarFill")
            firsStarView.image = UIImage(named: "Star")
        case 4..<6:
            fifthStarView.image = UIImage(named: "StarFill")
            fourthStarView.image = UIImage(named: "StarFill")
            thirdStarView.image = UIImage(named: "StarFill")
            secondStarView.image = UIImage(named: "Star")
            firsStarView.image = UIImage(named: "Star")
        case 2..<4:
            fifthStarView.image = UIImage(named: "StarFill")
            fourthStarView.image = UIImage(named: "StarFill")
            thirdStarView.image = UIImage(named: "Star")
            secondStarView.image = UIImage(named: "Star")
            firsStarView.image = UIImage(named: "Star")
        case 0..<2:
            fifthStarView.image = UIImage(named: "StarFill")
            secondStarView.image = UIImage(named: "Star")
            thirdStarView.image = UIImage(named: "Star")
            fourthStarView.image = UIImage(named: "Star")
            firsStarView.image = UIImage(named: "Star")
        default:
            fifthStarView.image = UIImage(named: "Star")
            secondStarView.image = UIImage(named: "Star")
            thirdStarView.image = UIImage(named: "Star")
            fourthStarView.image = UIImage(named: "Star")
            firsStarView.image = UIImage(named: "Star")
        }
    }

    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            allStuck.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            allStuck.leftAnchor.constraint(equalTo: leftAnchor),
            allStuck.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            allStuck.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

        ])
    }
}
