//
//  NowSingleMovie.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.02.2023.
//

// MARK: - Result
struct NowSingleMovie: Codable, Equatable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    static func ==(lhs: NowSingleMovie, rhs: NowSingleMovie) -> Bool {
        return lhs.title == rhs.title 
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
