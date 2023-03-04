//
//  MainReviewsControllerModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.03.2023.
//

import Foundation


struct MainReviewsControllerModel {
    //MARK: - Properties
    //Public
    public var pReviewModel: [SingleReviewModel?] {
        return reviewModel
    }
    public var listCount: Int {
        return reviewModel.count
    }
    
    public var reviewList: [SingleReviewModel?] {
        return reviewModel
    }
    //Private
    private let reviewModel: [SingleReviewModel?]
    init(reviewModel: [SingleReviewModel?]) {
        self.reviewModel = reviewModel
    }
    
    func getReview(with indexPath: IndexPath) -> SingleReviewModel? {
        return reviewList[indexPath.item]
    }
}
