//
//  DetaillViewTwo.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit
import SDWebImage

class RateTVDetaillView: UIView {
    enum RateTVDetaillViewType {
        case rate
        case popular
    }
//MARK: - Properties
    
    var vc: UIViewController
    
    var viewModel: RateDetaillTVViewModel
    
    let movieImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleMovieLabel: UILabel = {
       let label = UILabel()
        label.text = "Justice league".uppercased()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let watchingLabel: UILabel = {
       let label = UILabel()
        label.text = "3,292 People wathing"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let rateView: RateViewTwo = {
        let view = RateViewTwo()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "PlayButton"), for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()
    let infoLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Fueled by his restored faith in humanity and inspired by Superman's selfless act, Bruce Wayne enlists the help of his newfound ally, Diana Prince, to face an even greater enemy..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let peopleLable: UILabel = {
       let label = UILabel()
        label.text = "Full Cast & Crew"
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let bgPeopleLable: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let reactionView: ActionReactionView = {
       let rv = ActionReactionView()
        rv.backgroundColor = .systemGray5
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    let peopleListView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
                
    lazy var peopleController = CPeopleController(viewModel: CPeopleControllerViewModel(movieId: viewModel.movieId, type: .tv))
//MARK: - Init
    init(frame: CGRect, vc: UIViewController, viewModel: RateDetaillTVViewModel) {
        self.vc = vc
        self.viewModel = viewModel
        super.init(frame: frame)
        addSubview(movieImageView)
        addSubview(titleMovieLabel)
        addSubview(watchingLabel)
        addSubview(rateView)
        addSubview(playButton)
        addSubview(infoLabel)
        addSubview(bgPeopleLable)
        addSubview(peopleLable)
        addSubview(peopleListView)
        addSubview(reactionView)
        addConstraints()
        add(chaildVC: peopleController, to: peopleListView)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Private
    private func configure() {
        self.titleMovieLabel.text = viewModel.title
        infoLabel.text = viewModel.overview
        watchingLabel.text = "\(viewModel.voteCount ?? "") People wathing"
        self.rateView.rate = viewModel.rate
        guard let movieImageUrl = URL(string: viewModel.stringUrl) else { return }
        self.movieImageView.sd_setImage(with: movieImageUrl)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.48),
            
            titleMovieLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height / 5),
            titleMovieLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleMovieLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            watchingLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 10),
            watchingLabel.leftAnchor.constraint(equalTo: titleMovieLabel.leftAnchor),
            watchingLabel.rightAnchor.constraint(equalTo: titleMovieLabel.rightAnchor),
            rateView.topAnchor.constraint(equalTo: watchingLabel.bottomAnchor, constant: 10),
            rateView.leftAnchor.constraint(equalTo: titleMovieLabel.leftAnchor),
            rateView.widthAnchor.constraint(equalToConstant: 180),
            
            playButton.topAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -35),
            playButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            infoLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -10),
            
            bgPeopleLable.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            bgPeopleLable.leftAnchor.constraint(equalTo: leftAnchor),
            bgPeopleLable.rightAnchor.constraint(equalTo: rightAnchor),
            bgPeopleLable.heightAnchor.constraint(equalToConstant: 50),
            
            
            peopleLable.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            peopleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            peopleLable.rightAnchor.constraint(equalTo: rightAnchor),
            peopleLable.heightAnchor.constraint(equalToConstant: 50),
            
            peopleListView.topAnchor.constraint(equalTo: peopleLable.bottomAnchor),
            peopleListView.leftAnchor.constraint(equalTo: leftAnchor),
            peopleListView.rightAnchor.constraint(equalTo: rightAnchor),
            peopleListView.heightAnchor.constraint(equalToConstant: 150 ),
            
            reactionView.topAnchor.constraint(equalTo: peopleListView.bottomAnchor),
            reactionView.leftAnchor.constraint(equalTo: leftAnchor),
            reactionView.rightAnchor.constraint(equalTo: rightAnchor),
            reactionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func add(chaildVC: UIViewController, to containerView: UIView) {
         vc.addChild(chaildVC)
           containerView.addSubview(chaildVC.view)
           chaildVC.view.frame = containerView.bounds
           chaildVC.didMove(toParent: vc)
       }
}


