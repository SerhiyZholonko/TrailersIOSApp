//
//  MovieNowViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.02.2023.
//

import UIKit

class MovieNowDetaillViewController: UIViewController {
    var viewModel: NowDetaillViewViewModel
    //MARK: - Properties
    lazy var contentView: NowDetaillView = {
        let view = NowDetaillView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Init
    init(viewModel: NowDetaillViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        addConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
//       
    }
    //MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    
}


//MARK: - ex NowDetaillViewDelegtae

extension MovieNowDetaillViewController: NowDetaillViewDelegtae {
    func toreviewController(movieId: String) {
        let controller = ReviewsViewController(viewModel: ReviewsViewListModel(moviewId: movieId))
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
  
    
    func toVideoController(id: String) {
        let navVC = UINavigationController(rootViewController: MoviesVideoViewController(nibName: nil, bundle: nil, viewModel: VideoViewControllerViewModel(id: id)))
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
