//
//  InfoView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.02.2023.
//

import UIKit

class InfoView: UIView {
    var ganres: [Genre] {
        didSet {
            guard let last = ganres.last else {return}
            DispatchQueue.main.async {
                for name in self.ganres {
                    if name == last{
                        self.styleLabel.text! += " \(name.name ?? "") "
                    } else {
                        self.styleLabel.text! += " \(name.name ?? ""), "
                    }
                }
            }
        }
    }
    let voteCount: String
    let rate: Double
    lazy var countWathcingLabel: UILabel = {
       let label = UILabel()
        label.text = "\(voteCount) People wathing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var styleLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    lazy var rateView: RateView = {
        let view = RateView(frame: .zero, rate: self.rate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        countWathcingLabel,
        styleLabel,
        rateView
        ])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(frame: CGRect, rate: Double, voteCount: String?, garne: [Genre]?) {
        self.rate = rate
         self.voteCount = voteCount ?? ""
        self.ganres = garne ?? []
        super.init(frame: frame)
        addSubview(stackView)
        addConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            rateView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
}
