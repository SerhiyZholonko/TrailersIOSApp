//
//  MovieDetaillViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

class MoviePopularDetaillViewController: UIViewController {
    var viewModel: PopularDetaillViewViewModel
    //MARK: - Properties
    lazy var contentView: PopuplarDetaillView = {
        let view = PopuplarDetaillView(frame: .zero, viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Init
    init(viewModel: PopularDetaillViewViewModel) {
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

//MARK: ex  PopuplarDetaillViewDelegate

extension MoviePopularDetaillViewController: PopuplarDetaillViewDelegate {
    func toVideoController(id: String) {
        let vc = MoviesVideoViewController(nibName: nil, bundle: nil, viewModel: VideoViewControllerViewModel(id: id))
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
