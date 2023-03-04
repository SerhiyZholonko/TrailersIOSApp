//
//  MovieCollectionViewCellViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit

struct PopularCollectionViewCellViewModel: Hashable, Equatable {
    //MARK: - Properties
    
    //MARK: - Public
    var urlString: String {
        return Connstant.imageURL.title + (movie.posterPath ?? "")
    }
    var title: String {
        return movie.title ?? "Title"
    }
    
    var markMain: String {
        return marks[0]
    }
    var markSup: String {
        return marks[1]
    }
    var year: String {
        return movie.releaseDate!
    }
    var getMovie: SingleMovie {
        return movie
    }
  
    //MARK: - Private
    enum Connstant {
        case imageURL
        var title: String{
            switch self {
            case .imageURL:
                return "https://www.themoviedb.org/t/p/original/"
            }
        }
    }
    private  let marks: [String]
    private  let movie: SingleMovie
    //MARK: - Init
    init(movie: SingleMovie) {
        self.movie = movie
        self.marks =  "\(movie.voteAverage ?? 0.0)".components(separatedBy: ".")
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    // MARK: - Hashable

    static func == (lhs: PopularCollectionViewCellViewModel, rhs: PopularCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(urlString)
    }
}
