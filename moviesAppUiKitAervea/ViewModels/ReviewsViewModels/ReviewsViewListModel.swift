//
//  ReviewsViewListModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.03.2023.
//

import Foundation


final class ReviewsViewListModel {
    //MARK: - Properties
    //Public
    public var listCount: Int? {
        return reviewsList.count
    }

    //Private
    var reviewsList: [SingleReviewModel] = []
    
    private let moviewId: String
    //MARK: - init
    init(moviewId: String) {
        self.moviewId = moviewId
    }
    //Public func
    public func fetchReview() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: [moviewId, "reviews",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: ReviewModel.self) { result in
            switch result {
            case .success(let review):
                print("Review: ", review)
                guard let results = review.results else { return }
                self.reviewsList = results
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}
