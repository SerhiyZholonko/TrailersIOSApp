//
//  TVReviewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 15.03.2023.
//

import Foundation

// MARK: - TVReviewsModel
struct TVReviewsModel: Codable {
    let id, page: Int
    let results: [SoloTVReview]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SoloTVReview: Codable {
    let author: String
    let authorDetails: TVAuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct TVAuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
