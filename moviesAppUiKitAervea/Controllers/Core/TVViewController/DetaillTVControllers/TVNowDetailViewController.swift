//
//  File.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 16.02.2023.
//

import UIKit

class TVNowDetailViewController: UIViewController {
    var viewModel: TVNowDetaillViewModel
    //MARK: - Properties
    lazy var contentView: TVNowDetailView = {
        let view = TVNowDetailView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Init
    init(viewModel: TVNowDetaillViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewController = self
        contentView.delegate = self
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


extension TVNowDetailViewController: TVNowDetailViewDeligate {
    func toreviewController(movieId: String) {
        let controller = ReviewsViewController(viewModel: ReviewsViewListModel(moviewId: movieId, type: .topTVShow))
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    func toVideo(id: String) {
        let vc = TVShowVideoViewController(nibName: nil, bundle: nil, viewModel: VideoViewControllerViewModel(id: id))
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
}
