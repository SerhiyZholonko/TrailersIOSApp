//
//  MorePopularListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

protocol MorePopularListViewModelDelegate: AnyObject {
    func toDetaillView(singleTVShow: SinglePopularShow)
}

final class MorePopularListViewModel: NSObject {
    weak var delegate: MorePopularListViewModelDelegate?
    var viewModel: [PopularTVCollectionViewCellModel] = []
    var refreshMovies: [PopularTVCollectionViewCellModel] = []
    init(rateTVShows: [PopularTVCollectionViewCellModel]) {
        self.viewModel = rateTVShows
        self.refreshMovies = rateTVShows
    }
    func callBack(text: String, complition: @escaping () -> Void) {
        var newMovieArray = [PopularTVCollectionViewCellModel]()
        for item in viewModel {
            if item.titleTV.contains(text) {
                newMovieArray.append(item)
            }
            if !newMovieArray.isEmpty {
                self.viewModel = newMovieArray
                complition()
            }
                    if text == "" {
                        viewModel = refreshMovies
                        complition()
                    }
        }
    }
}

extension MorePopularListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularTVCollectionViewCell.identifier, for: indexPath) as! PopularTVCollectionViewCell
        cell.configureCell(with: viewModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        return .init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleTVShow = viewModel[indexPath.item].publicTVShow
        delegate?.toDetaillView(singleTVShow: singleTVShow)
    }
    
}
