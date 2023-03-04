//
//  ReviewsView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.02.2023.
//

import UIKit

class ReviewsView: UIView {
    //MARK: - Properties
    let viewModel: ReviewsViewModel
    let vc: UIViewController
    lazy var controller: MainReviewsController = {
        let layout = UICollectionViewFlowLayout()
        let controller = MainReviewsController(viewModel: MainReviewsControllerModel(reviewModel: viewModel.pReviewModel))
        return controller
    }()
    //MARK: - init
     init(frame: CGRect, vc: UIViewController, viewModel: ReviewsViewModel) {
         self.vc = vc
         self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
         vc.add(chaildVC: controller, to: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
