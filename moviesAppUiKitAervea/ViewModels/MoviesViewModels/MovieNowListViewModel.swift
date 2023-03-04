//
//  MovieNowListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit


protocol MovieNowListViewModelDelegate: AnyObject {
    func toDetailController(singleMovie: NowSingleMovie)
}
final class MovieNowListViewModel: NSObject {
    weak var delegate: MovieNowListViewModelDelegate?
    var viewModel: [NowCollectionViewCellViewModel] = []
    var refreshMovies: [NowCollectionViewCellViewModel] = []
    
    init(nowMovies: [NowCollectionViewCellViewModel]) {
        self.refreshMovies = nowMovies
        self.viewModel = nowMovies
    }
    func callBack(text: String, complition: @escaping () -> Void) {
        var newMovieArray = [NowCollectionViewCellViewModel]()
        for item in viewModel {
            
            if item.title.contains(text) {
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

extension MovieNowListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.identifier, for: indexPath) as! NowCollectionViewCell
        cell.configure(with: viewModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviewsHeaderNowCollectionReusableView.identifier, for: indexPath) as? MoviewsHeaderNowCollectionReusableView else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleMovie = viewModel[indexPath.item].getMovie
        delegate?.toDetailController(singleMovie: singleMovie)
    }
    
    
}



    

    
