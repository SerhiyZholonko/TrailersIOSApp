//
//  TVPopularDetailViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 14.02.2023.
//

import UIKit

class TVPopularDetailViewController: UIViewController {
    var viewModel: TVPopopularDetailViewModel
    //MARK: - Properties
    lazy var contentView: TVPopularDetailView = {
        let view = TVPopularDetailView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Init
    init(viewModel: TVPopopularDetailViewModel) {
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


//MARK: - ex TVPopularDetailViewDelegate

extension TVPopularDetailViewController: TVPopularDetailViewDelegate {
    func toreviewController(movieId: String) {
        let controller = ReviewsViewController(viewModel: ReviewsViewListModel(moviewId: movieId, type: .popularTVShow))
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    func toVideoControler(id: String) {
        let navVC = UINavigationController(rootViewController: TVShowVideoViewController(nibName: nil, bundle: nil, viewModel: VideoViewControllerViewModel(id: id)))
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    
}
