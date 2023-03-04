//
//  NowTVCollectionViewCellModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit


struct RateTVCollectionViewCellModel {
    //MARK: - Properties
    //MARK: - Public
    public var titleTV: String {
        return title
    }
    public var topStringUrl: String {
        return "https://www.themoviedb.org/t/p/original/" + stringUrl
    }
    public var publicTVShow: SingleTopShow {
        return movie
    }
    //MARK: - Private
    private let movie: SingleTopShow
    
    private let title: String
    private let stringUrl: String
    init( movie: SingleTopShow) {
        self.movie = movie
        self.title = movie.name ?? ""
        self.stringUrl = movie.posterPath ?? ""
    }
}
