//
//  NowDetaillViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.02.2023.
//

import UIKit

protocol NowDetaillViewViewModelDelegate: AnyObject {
    func setupGanre(with ganre: [Genre])
}

final class NowDetaillViewViewModel {
    //MARK: - Properties
    //MARK: - Public
    weak var delegate: NowDetaillViewViewModelDelegate?
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
    public var pId: String {
        return "\(movie.id ?? 0)"
    }
    public var ganres: [Genre]? {
        guard let nowMovieDetail = nowMovieDetail else { return nil}
        return nowMovieDetail.genres
    }
    public var year: String {
        return movie.releaseDate ?? " "
    }
    public var publicId: Int? {
        return movie.id
    }
//

    //MARK: - Private
    private let movie: NowSingleMovie
    private var nowMovieDetail: MovieDetailsModel? {
        didSet {
            guard let ganres = ganres else { return }
            delegate?.setupGanre(with: ganres)
        }
    }
    func addToFavorite() {
        let movies: [CDMovie] = CoreDataManager.shared.fetchData(entityName: "CDMovie")
        for movie in movies {
            if movie.uniqueIdentifierKey == pId {
                return
            }
        }
            let movie = CDMovie(context: CoreDataManager.shared.managedObjectContext)
        movie.uniqueIdentifierKey = pId
            movie.title = title
            movie.stringUrl = stringUrl
        CoreDataManager.shared.save(movie)
            DataService.shared.setFavoriteStatus(for: title, with: false)
    }
   
     func fetchDetailMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["\(movie.id ?? 0)",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: MovieDetailsModel.self) { result in
            switch result {
                
            case .success(let nowMovie):
                self.nowMovieDetail = nowMovie
                print("DETAIL: ", self.nowMovieDetail!)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    //Private
    private func checkDublicatMovie() {
     
    }
  //MARK: - Init
    init(vc: UIViewController? = nil, movie: NowSingleMovie) {
        self.viewController = vc
        self.movie = movie
    }
    
    //hear add fetch func
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = URL(string: stringUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }

}
