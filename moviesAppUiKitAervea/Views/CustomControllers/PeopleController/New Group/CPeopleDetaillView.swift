//
//  CPeopleDetaillView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 25.02.2023.
//

import UIKit
import SDWebImage

protocol CPeopleDetaillViewDelegate: AnyObject {
    func closeViewCintroller()
}

final class CPeopleDetaillView: UIView {
    //MARK: - Properties
    weak var delegate: CPeopleDetaillViewDelegate?
    var viewModel: CPeopleDetailViewModel
    let actorPhotoImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let supNameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    let nameLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Firstname Lastname"
        return label
    }()
    lazy var nameLabelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
        supNameLabel, nameLabel
        ])
        sv.spacing = 10
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let supBirthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "birthday"
        label.textColor = .systemGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    var birthdayLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "27.04.1987"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var birthdayLabelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
        supBirthdayLabel,
        birthdayLabel
        ])
        sv.spacing = 10
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let supGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "gender"
        label.textColor = .systemGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let genderLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "famale"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var genderLabelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
        supGenderLabel, genderLabel
        ])
        sv.spacing = 10
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var actorLabelsStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        nameLabelsStack,
        birthdayLabelsStack,
        genderLabelsStack
       ])
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let contentScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bioLabel: UILabel = {
       let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTappedCloseButton), for: .touchUpInside)
        return button
    }()
    let scrollView = UIScrollView()
    let contentView = UIView()
    //MARK: - Init
    init(frame: CGRect, viewModel: CPeopleDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(actorPhotoImageView)
        addSubview(closeButton)
        addSubview(actorLabelsStack)
        addSubview(contentScrollView)
        addConstraints()
        setupScrollView(view: contentScrollView)
        setupViews()
        self.viewModel.fetchSingleActor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            actorPhotoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            actorPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorPhotoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            actorPhotoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: actorPhotoImageView.topAnchor),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            actorLabelsStack.topAnchor.constraint(equalTo: actorPhotoImageView.bottomAnchor, constant: 20),
            actorLabelsStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            actorLabelsStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            contentScrollView.topAnchor.constraint(equalTo: actorLabelsStack.bottomAnchor),
            contentScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentScrollView.rightAnchor.constraint(equalTo: rightAnchor),


        ])
    }
    func setupScrollView(view: UIView){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    private func setupViews(){
        contentView.addSubview(bioLabel)
        bioLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bioLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bioLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        bioLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    //MARK: selector
    @objc private func didTappedCloseButton() {
        delegate?.closeViewCintroller()
    }
   
}


extension CPeopleDetaillView: CPeopleDetailViewModelDelegate {
    func reloadModel(viewModel: CPeopleDetailViewModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.name
            self.birthdayLabel.text = viewModel.bithday
            self.genderLabel.text = viewModel.gender
            self.bioLabel.text = viewModel.bio
            guard let url = URL(string: viewModel.imageUrl) else {return}
            self.actorPhotoImageView.sd_setImage(with: url)
        }
    }
    
    
}
