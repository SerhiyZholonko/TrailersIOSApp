//
//  NowCollectionViewCellViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit

struct NowCollectionViewCellViewModel: Equatable {
    //MARK: - Properties
    
    //MARK: - Public
    var urlSring: String {
        return Connstant.imageURL.title + (movie.posterPath ?? "")
    }
    var title: String {
        return movieName
    }
    var getMovie: NowSingleMovie {
        return movie
    }
    var searchCallBack: ((String) -> Void)?
    static func ==(lhs: NowCollectionViewCellViewModel, rhs: NowCollectionViewCellViewModel) -> Bool {
        return lhs.title == rhs.title
    }
    //MARK: - Pivate
    
    enum Connstant {
        case imageURL
        var title: String{
            switch self {
            case .imageURL:
                return "https://www.themoviedb.org/t/p/original/"
            }
        }
    }
    private let movieName: String
    private let movieImage: String
    private let movie: NowSingleMovie
    init(movie: NowSingleMovie) {
        self.movie = movie
        self.movieName = movie.title ?? "Title"
        self.movieImage = movie.posterPath ?? " "
    }
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = URL(string: urlSring) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
