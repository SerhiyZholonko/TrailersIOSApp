//
//  CPeopleController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 04.02.2023.
//

import UIKit



private let reuseIdentifier = "Cell"

class CPeopleController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let viewModel: CPeopleControllerViewModel
    
    let layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    init(viewModel: CPeopleControllerViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
        self.viewModel.delegate = self
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CPeopleCollectionViewCell.self, forCellWithReuseIdentifier: CPeopleCollectionViewCell.identifier)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
    }

    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CPeopleCollectionViewCell.identifier, for: indexPath) as? CPeopleCollectionViewCell else { return UICollectionViewCell()}
         let cast = viewModel.getCurenItem(index: indexPath.item)
        cell.configureCell(with: cast)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 130)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(CPeopleDetailViewController(viewModel: CPeopleDetailViewControllerModel(actorId: "\(viewModel.movieActors[indexPath.item].id ?? 0)")), animated: true)
    }

}


extension CPeopleController: CPeopleControllerViewModelDelegate {
  
    func reladCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}
