//
//  MoreTopListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

protocol MoreTopListViewModelDelegate: AnyObject {
    func toDetaillView(singleTVShow: SingleTopShow)
}

final class MoreTopListViewModel: NSObject {
    weak var delegate: MoreTopListViewModelDelegate?
    var viewModel: [RateTVCollectionViewCellModel] = []
    var refreshMovies: [RateTVCollectionViewCellModel] = []

    init(rateTVShows: [RateTVCollectionViewCellModel]) {
        self.viewModel = rateTVShows
        self.refreshMovies = rateTVShows
    }
    func callBack(text: String, complition: @escaping () -> Void) {
        var newMovieArray = [RateTVCollectionViewCellModel]()
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

extension MoreTopListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTVCollectionViewCell.identifier, for: indexPath) as! TopTVCollectionViewCell
        cell.configureCell(with: viewModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleTVShow = viewModel[indexPath.item].publicTVShow
        delegate?.toDetaillView(singleTVShow: singleTVShow)
    }
    
}

