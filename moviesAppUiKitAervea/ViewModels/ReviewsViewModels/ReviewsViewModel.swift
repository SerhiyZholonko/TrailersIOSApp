//
//  ReviewsViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.03.2023.
//

import Foundation


struct ReviewsViewModel {
    //MARK: - Properties
    //Public
    public var pReviewModel: [SingleReviewModel?] {
        return reviewModel
    }
    //Private
   private let reviewModel: [SingleReviewModel?]
    init(reviewModel: [SingleReviewModel?]) {
        self.reviewModel = reviewModel
    }
}
