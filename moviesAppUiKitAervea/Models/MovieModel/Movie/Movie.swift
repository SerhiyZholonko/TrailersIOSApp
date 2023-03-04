//
//  Movie.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 09.02.2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let page: Int?
    let results: [SingleMovie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
