//
//  ProfileView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.03.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didImageViewTapped()
    func didEditButtonTapped()
}

final class ProfileView: UIView {
    //MARK: Properties
    weak var delegate: ProfileViewDelegate?
    lazy var userImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "logo1")
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.systemGray.cgColor
        iv.layer.borderWidth = 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(didImagePiker))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    var userLabel : UILabel = {
        let label = UILabel()
        label.text = "Enter your name"
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemGray.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBackground
        button.tintColor = .systemGray
        button.setBackgroundImage(UIImage(systemName: "square.and.pencil.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didEditTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(userImage)
        addSubview(userLabel)
        addSubview(editButton)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Public
    public func setImage(with image: UIImage ) {
        DispatchQueue.main.async {
            self.userImage.image = image
        }
    }
    //Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -45),
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100),
            
            userLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            userLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            userLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 50),
            
            editButton.widthAnchor.constraint(equalToConstant: 35),
            editButton.heightAnchor.constraint(equalToConstant: 35),
            editButton.topAnchor.constraint(equalTo: userLabel.topAnchor, constant: -10),
            editButton.rightAnchor.constraint(equalTo: userLabel.rightAnchor, constant: 10)
        ])
    }
    //Selector
    
    @objc private func didEditTapped() {
        delegate?.didEditButtonTapped()
    }
    @objc private func didImagePiker() {
        delegate?.didImageViewTapped()
    }
}
