//
//  NowMovies.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 11.02.2023.
//

import Foundation

// MARK: - NowMovies
struct NowMovies: Codable {
    let dates: Dates?
    let page: Int
    let results: [NowSingleMovie]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}



