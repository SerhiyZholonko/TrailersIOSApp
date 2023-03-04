//
//  PopularTVCollectionViewCellModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit


struct PopularTVCollectionViewCellModel {
    //MARK: - Properties
    //MARK: - Public
    public var titleTV: String {
        return title
    }
    public var stringUrlTV: String? {
        if stringUrl == "" {
            return nil
        }
        return "https://www.themoviedb.org/t/p/original/" + stringUrl
    }
    public var rateTV: String {
        return rate
    }
    var markMain: String {
        return self.marks[0]
    }
    var markSup: String {
        return self.marks[1]
    }
    public var publicTVShow: SinglePopularShow {
        return movie
    }
    //MARK: - Private
    private let title: String
    private let stringUrl: String
    private let rate: String
    private let marks: [String]
    private let movie: SinglePopularShow
    //MARK: - Init
    init(movie: SinglePopularShow) {
        self.title = movie.name ?? ""
        self.stringUrl = movie.backdropPath ?? ""
        self.rate = "\(movie.voteAverage ?? 0.0)"
        self.marks =  rate.components(separatedBy: ".")
        self.movie = movie
    }
}
