//
//  NowDetaillView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.02.2023.
//

import UIKit
import SDWebImage

protocol NowDetaillViewDelegtae: AnyObject {
    func toVideoController(id: String)
    func toreviewController(movieId: String)
}

class NowDetaillView: UIView {
    //MARK: - Properties
    var delegate: NowDetaillViewDelegtae?
    var viewModel: NowDetaillViewViewModel

    let videoImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let movieImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title".uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "PlayButton"), for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTappedPlayButton), for: .touchUpInside)
        return button
    }()
    lazy var infoView: InfoView = {
        let InfoView = InfoView(frame: .zero, rate: self.viewModel.rate, voteCount: viewModel.voteCount, garne: viewModel.ganres)
        InfoView.translatesAutoresizingMaskIntoConstraints = false
        return InfoView
    }()
    let descriptionView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Fueled by his restored faith in humanity and inspired by Superman's selfless act, Bruce Wayne enlists the help of his newfound ally, Diana Prince, to face an even greater enemy."
        label.numberOfLines = 0
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
    lazy var reactionView: ReactionView = {
        let rv = ReactionView(frame: .zero, viewModel: ReactionViewModel(nameMoview: viewModel.title))
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
    let scrollView = UIScrollView()
    let contentView = UIView()
    lazy var peopleController = CPeopleController(viewModel: CPeopleControllerViewModel(movieId: viewModel.publicId, type: .movie))
    //MARK: - init
    init(frame: CGRect, viewModel: NowDetaillViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel.delegate = self
        reactionView.delegate = self
        self.viewModel.fetchDetailMovie()
        addSubview(descriptionView)
        addSubview(videoImageView)
        addSubview(playButton)
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(bgPeopleLable)
        addSubview(peopleLable)
        addSubview(peopleListView)
        addSubview(reactionView)
        addSubview(infoView)
        addConstraints()
        setupScrollView()
        descriptionView.addSubview(descriptionLabel)
        setupeConstrainsDescriptionLabel()
        setupMovie()
        add(chaildVC: peopleController, to: peopleListView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private
    
    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: descriptionView.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: descriptionView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            videoImageView.topAnchor.constraint(equalTo: topAnchor),
            videoImageView.leftAnchor.constraint(equalTo: leftAnchor),
            videoImageView.rightAnchor.constraint(equalTo: rightAnchor),
            videoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),

            
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.centerXAnchor.constraint(equalTo: videoImageView.centerXAnchor, constant: 20),
            playButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            movieImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            movieImageView.heightAnchor.constraint(equalToConstant: 170),
            movieImageView.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: -60),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),


            titleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: -10),
            
            infoView.topAnchor.constraint(equalTo: videoImageView.bottomAnchor),
            infoView.leftAnchor.constraint(equalTo: movieImageView.rightAnchor),
            infoView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            infoView.rightAnchor.constraint(equalTo: rightAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionView.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            descriptionView.heightAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 0.5),
            
            bgPeopleLable.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            bgPeopleLable.leftAnchor.constraint(equalTo: leftAnchor),
            bgPeopleLable.rightAnchor.constraint(equalTo: rightAnchor),
            bgPeopleLable.heightAnchor.constraint(equalToConstant: 30),
            
            peopleLable.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            peopleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            peopleLable.rightAnchor.constraint(equalTo: rightAnchor),
            peopleLable.heightAnchor.constraint(equalToConstant: 30),
            
            peopleListView.topAnchor.constraint(equalTo: peopleLable.bottomAnchor),
            peopleListView.leftAnchor.constraint(equalTo: leftAnchor),
            peopleListView.rightAnchor.constraint(equalTo: rightAnchor),
            peopleListView.heightAnchor.constraint(equalToConstant: 150),
            
            reactionView.topAnchor.constraint(equalTo: peopleListView.bottomAnchor),
            reactionView.leftAnchor.constraint(equalTo: leftAnchor),
            reactionView.rightAnchor.constraint(equalTo: rightAnchor),
            reactionView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    private func setupeConstrainsDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3.5/4),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    private func setupMovie() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        guard let url = URL(string: viewModel.videoUrl) else { return }
        videoImageView.sd_setImage(with: url)
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.movieImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
   private func add(chaildVC: UIViewController, to containerView: UIView) {
       guard let vc = viewModel.viewController else { return }
       vc.addChild(chaildVC)
          containerView.addSubview(chaildVC.view)
          chaildVC.view.frame = containerView.bounds
       chaildVC.didMove(toParent: viewModel.viewController)
      }
    //Selector
    @objc private func didTappedLikeButton() {
        print("like")
    }
    @objc private func didTappedPlayButton() {
        delegate?.toVideoController(id: viewModel.pId)
    }
}



//MARK: - delegate

extension NowDetaillView: NowDetaillViewViewModelDelegate {
    func setupGanre(with ganre: [Genre]) {
        infoView.ganres = ganre
    }
}
extension NowDetaillView: ReactionViewDalegate {
    func didTappedFavorite() {
        viewModel.addToFavorite()
    }
    
    func didTappedComment() {

        delegate?.toreviewController(movieId: viewModel.pId)
    }
    
    func didTappedLike() {
        print("Like main delegate")
    }
}
