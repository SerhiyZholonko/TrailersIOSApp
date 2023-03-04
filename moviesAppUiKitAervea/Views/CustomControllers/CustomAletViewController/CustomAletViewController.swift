//
//  CustomAletViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 17.02.2023.
//

import UIKit

class CustomAletViewController: UIViewController {
    //MARK: - Properties
    let viewModel: AlertViewModel
    let bgColor: UIColor = .init(white: 0.9, alpha: 0.3)
    lazy var contentView: AlertView = {
        let view = AlertView(frame: .zero, viewModel: self.viewModel)
        return view
    }()
    init(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        setupMainView()
        view.addSubview(contentView)
        addConstraints()
    }
    
    //MARK: - Private
    private func setupMainView() {
        view.backgroundColor = bgColor
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            contentView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


//MARK: - ex AlertViewDelegate

extension CustomAletViewController: AlertViewDelegate {
    func touchedDismiss() {
        dismiss(animated: true)
    }
}
