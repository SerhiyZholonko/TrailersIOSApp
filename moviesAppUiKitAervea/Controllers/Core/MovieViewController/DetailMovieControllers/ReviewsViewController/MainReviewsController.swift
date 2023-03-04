//
//  MainReviewsController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.02.2023.
//

import UIKit

final class MainReviewsController: UIViewController {
    
    public let viewModel: MainReviewsControllerModel
    
    var collectionView: UICollectionView!

    
    init(viewModel: MainReviewsControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Create a UICollectionViewFlowLayout instance
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        // Create a UICollectionView instance
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        // Set up constraints for the UICollectionView
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Register the CommentHeader and ReplyCell classes for use with the UICollectionView
        collectionView.register(CommentHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CommentHeaderIdentifier")
        collectionView.register(LikeCell.self, forCellWithReuseIdentifier: "ReplyCellIdentifier")

        collectionView.delegate = self
        collectionView.dataSource = self

    }


}


extension MainReviewsController: UICollectionViewDataSource, UICollectionViewDelegate {



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let replyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReplyCellIdentifier", for: indexPath) as! LikeCell
        
        replyCell.configure(with: viewModel.getReview(with: indexPath))
        return replyCell

    }



}

extension MainReviewsController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 100) // this height is used for the example, you can use self sizing for height

    }

}

