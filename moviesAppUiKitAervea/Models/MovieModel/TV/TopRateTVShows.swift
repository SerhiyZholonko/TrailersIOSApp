//
//  TopRateTV.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import Foundation

// MARK: - TopRateTVShows
struct TopRateTVShows: Codable {
    let page: Int?
    let results: [SingleTopShow]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SingleTopShow: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let name: String?
    let originCountry: [OriginCountry]?
    let originalLanguage: OriginalLanguage?
    let originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginCountry: String, Codable {
    case ca = "CA"
    case jp = "JP"
    case kr = "KR"
    case us = "US"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case ko = "ko"
}
