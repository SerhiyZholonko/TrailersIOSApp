//
//  ReviewsViewHeaderModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.02.2023.
//

import UIKit

struct ReviewsViewHeaderModel {
    public var pReviewsCount: String {
        return reviewsCount
    }
    private let reviewsCount: String
    init(reviewsCount: String) {
        self.reviewsCount = reviewsCount
    }
}
