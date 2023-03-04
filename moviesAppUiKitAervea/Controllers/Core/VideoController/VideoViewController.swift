//
//  VideoViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 16.02.2023.
//

import UIKit
import YouTubeiOSPlayerHelper


class VideoViewController: UIViewController {
    public var viewModel: VideoViewControllerViewModel 
    let videoView : YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: VideoViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupConfiguraMainView()
       
        
    }
    //MARK: - private
    private func setupConfiguraMainView() {
        view.backgroundColor = .black
        view.addSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.widthAnchor.constraint(equalToConstant: view.frame.width),
            videoView.heightAnchor.constraint(equalToConstant: 350),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(didTapBack))
        navigationController?.navigationBar.tintColor = .white
    }
     func loadVideo() {
        DispatchQueue.main.async { [weak self] in
            self?.videoView.load(withVideoId: self?.viewModel.singleTrailer?.key ?? "")
                       }
    }
    //MARK: - selector
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
}

