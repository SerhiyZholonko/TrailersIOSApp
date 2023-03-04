//
//  TVShowVideoViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 23.02.2023.
//

import Foundation



final class TVShowVideoViewController: VideoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTrailerTVShows(idMovie: viewModel.id) {[weak self] id in
            DispatchQueue.main.async {
                self?.videoView.load(withVideoId: id)
            }
        }
        loadVideo()
    }
}
