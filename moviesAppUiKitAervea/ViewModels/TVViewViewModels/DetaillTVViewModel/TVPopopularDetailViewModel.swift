//
//  TVPopopularDetailViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 14.02.2023.
//

import UIKit

final class TVPopopularDetailViewModel {
    //MARK: - Properties

    //MARK: - Public
    public var viewController: UIViewController?
    public var title: String {
        return movie.name ?? "Title"
    }
    public var description: String? {
        return movie.overview
    }
    public var stringUrl: String {
        let stringUrl = movie.posterPath ?? " "
        return  "https://www.themoviedb.org/t/p/original/" + stringUrl
    }
    public var videoUrl: String {
        let stringUrl = movie.backdropPath ?? ""
        return "https://www.themoviedb.org/t/p/original/" + stringUrl
    }
    public var rate: Double {
        return  Double(movie.voteAverage ?? 0.0)
    }
    public var voteCount: String? {
        return "\(movie.voteCount ?? 0)"
    }
    public var year: String {
        return movie.firstAirDate ?? " "
    }
    public var movieId: Int {
        return movie.id ?? 0
    }
    //MARK: - Private
    private let movie: SinglePopularShow
  //MARK: - Init
    init(vc: UIViewController? = nil, movie: SinglePopularShow) {
        self.viewController = vc
        self.movie = movie
    }
    func addToFavorite() {
        let movie = CDMovie(context: CoreDataManager.shared.managedObjectContext)
        movie.title = title
        movie.stringUrl = stringUrl
        CoreDataManager.shared.save(movie)
    }
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = URL(string: stringUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }

}
