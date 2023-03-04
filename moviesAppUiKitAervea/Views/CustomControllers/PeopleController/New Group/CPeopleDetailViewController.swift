//
//  CPeopleDetailViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 25.02.2023.
//

import UIKit

class CPeopleDetailViewController: UIViewController {
//MARK: - Properties
    let viewModel: CPeopleDetailViewControllerModel
    lazy var contentView: CPeopleDetaillView = {
        let view = CPeopleDetaillView(frame: .zero, viewModel: .init(actorId: viewModel.pActorId) )
        return view
    }()
    init(viewModel: CPeopleDetailViewControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.contentView.delegate = self
        view.addSubview(contentView)
        addConstraints()
    }
    
    //Private
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}




extension CPeopleDetailViewController: CPeopleDetaillViewDelegate {
    func closeViewCintroller() {
        dismiss(animated: true)
    }
    
    
}
