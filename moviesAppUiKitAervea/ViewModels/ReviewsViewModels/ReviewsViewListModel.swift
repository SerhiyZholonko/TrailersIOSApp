//
//  ReviewsViewListModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.03.2023.
//

import Foundation

protocol ReviewsViewListModelDelegate: AnyObject {
    func getReviews(viewModel: ReviewsViewListModel)
}
enum ReviewsViewListModelType {
    case nowMovie
    case popularMovie
    case topTVShow
    case popularTVShow
}
final class ReviewsViewListModel {
    //MARK: - Properties
    weak var delegate: ReviewsViewListModelDelegate?
    //Public
    var type: ReviewsViewListModelType
    public var listCount: Int {
        return nowReviewsList.count

    }
    //Private
    var nowReviewsList: [SingleReviewModel] = []
    var topTVShowReviewsList: [SingleTopShow] = []
    var nowMovie: NowSingleMovie?
    var popularMovie: SinglePopularShow?
    var topTVShow: SingleTopShow?
    var popularTVShow: SinglePopularShow?
    private var moviewId: String
    //MARK: - init
    init(moviewId: String, type: ReviewsViewListModelType) {
        self.type = type
        self.moviewId = moviewId
        print("idTT: ",moviewId)
        switch type {
        case .nowMovie:
            fetchNowMovie()
        case .topTVShow:
            fetchNowTVShow()
        case .popularMovie:
            fetchPopularMovie()
        case .popularTVShow:
            fetchPopularTVShow() 
        }
        switch type {
            
        case .nowMovie:
            fetchReview()
        case .popularMovie:
            fetchReview()
        case .topTVShow:
            fetchTVReview()
        case .popularTVShow:
            fetchTVReview()
        }
        
    }

    //Public func
    public func getSingleReviewModel(indexPath: IndexPath) -> SingleReviewModel {
        return nowReviewsList[indexPath.item]
    }
    private func fetchNowMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["now_playing",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: NowMovies.self) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
//                self?.nowMovies = singleMovies
                for movie in singleMovies {
                    if "\(movie.id ?? 0)" == self?.moviewId {
                        self?.nowMovie = movie
                    }
                }
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print(error)
            }
            
        }
    }
    private func fetchPopularMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["popular",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: PopularTVShows.self) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
//                self?.nowMovies = singleMovies
                for movie in singleMovies {
                    if "\(movie.id ?? 0)" == self?.moviewId {
                        self?.popularMovie = movie
                    }
                }
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print("popularMovieErorr: ", error)
            }
            
        }
    }
    private func fetchNowTVShow() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["top_rated",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: TopRateTVShows.self) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
//                self?.nowMovies = singleMovies
                for movie in singleMovies {
                    if "\(movie.id ?? 0)" == self?.moviewId {
                        self?.topTVShow = movie
                    }
                }
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print(error)
            }
            
        }
    }
    private func fetchPopularTVShow() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["popular",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: PopularTVShows.self) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
//                self?.nowMovies = singleMovies
                print("singleMovies: ", singleMovies)
                for movie in singleMovies {
                    if "\(movie.id ?? 0)" == self?.moviewId {
                        self?.popularTVShow = movie
                    }
                }
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print(error)
            }
            
        }
    }
    public func fetchReview() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: [moviewId, "reviews",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: ReviewModel.self) { [weak self] result in
            switch result {
            case .success(let review):
                                    guard let results = review.results else { return }
                                    self?.nowReviewsList = results
                                    self?.delegate?.getReviews(viewModel: self!)

            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    public func fetchTVReview() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: [moviewId, "reviews",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: ReviewModel.self) { [weak self] result in
            switch result {
            case .success(let review):
                                    guard let results = review.results else { return }
                                    self?.nowReviewsList = results
                                    self?.delegate?.getReviews(viewModel: self!)

            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}
