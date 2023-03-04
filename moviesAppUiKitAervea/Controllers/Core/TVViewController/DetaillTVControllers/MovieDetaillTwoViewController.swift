//
//  MovieDetaillTwoViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 05.02.2023.
//

import UIKit

class MovieDetaillTwoViewController: UIViewController {
    
    var viewModel: RateDetaillTVViewModel
    lazy var contentView: RateTVDetaillView = {
        let view = RateTVDetaillView(frame: .zero, vc: CPeopleController(viewModel: CPeopleControllerViewModel(movieId: viewModel.movieId, type: .tv)), viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        addConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .white
    }
    init(viewModel: RateDetaillTVViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

