//
//  MoviesVideoController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 23.02.2023.
//

import UIKit



final class MoviesVideoViewController: VideoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTrailerMovies(idMovie: viewModel.id) {[weak self] id in
            DispatchQueue.main.async {
                self?.videoView.load(withVideoId: id)
            }
        }
        loadVideo()
    }
}
