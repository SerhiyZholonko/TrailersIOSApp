//
//  DetaillViewViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit

protocol PopularDetaillViewViewModelDelegate: AnyObject {
    func setupGanre(with ganre: [Genre])
}

final class PopularDetaillViewViewModel {
    //MARK: - Properties
    weak var delegate: PopularDetaillViewViewModelDelegate?

    //MARK: - Public
    public var viewController: UIViewController?
    public var title: String {
        return movie.title ?? "Title"
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
        return movie.releaseDate ?? " "
    }
    public var ganres: [Genre]? {
        guard let popularMovieDetail = popularMovieDetail else { return nil}
        return popularMovieDetail.genres
    }
    public var publicId: Int {
        return movie.id ?? 0
    }
    private var popularMovieDetail: MovieDetailsModel? {
        didSet {
            guard let ganres = ganres else { return }
            delegate?.setupGanre(with: ganres)
        }
    }
    func addToFavorite() {
        let movies: [CDMovie] = CoreDataManager.shared.fetchData(entityName: "CDMovie")
        for movie in movies {
            if movie.uniqueIdentifierKey == "\(publicId)" {
                return
            }
        }
        let movie = CDMovie(context: CoreDataManager.shared.managedObjectContext)
        movie.uniqueIdentifierKey = "\(publicId)"
        movie.title = title
        movie.stringUrl = stringUrl
        CoreDataManager.shared.save(movie)
    }
     func fetchDetailMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["\(movie.id ?? 0)",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: MovieDetailsModel.self) { result in
            switch result {
                
            case .success(let nowMovie):
                self.popularMovieDetail = nowMovie
                print("DETAIL: ", self.popularMovieDetail!)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    //MARK: - Private
    private func checkDublicatMovie() {
        let movies: [CDMovie] = CoreDataManager.shared.fetchData(entityName: "CDMovie")
        for movie in movies {
            if movie.uniqueIdentifierKey == "\(publicId)" {
                return
            }
        }
    }
    private let movie: SingleMovie
  //MARK: - Init
    init(vc: UIViewController? = nil, movie: SingleMovie) {
        self.viewController = vc
        self.movie = movie
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
