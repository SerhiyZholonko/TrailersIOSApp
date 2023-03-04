//
//  MoviePopularListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

protocol MoviePopularListViewModelDelegate: AnyObject {
    func toDetailView(singleMovie: SingleMovie)
}

final class MoviePopularListViewModel: NSObject {
    weak var delegate: MoviePopularListViewModelDelegate?
    var viewModel: [PopularCollectionViewCellViewModel] = []
    var refreshMovies: [PopularCollectionViewCellViewModel] = []
    init(nowMovies: [PopularCollectionViewCellViewModel]) {
        self.viewModel = nowMovies
        self.refreshMovies = nowMovies
    }
    func callBack(text: String, complition: @escaping () -> Void) {
        var newMovieArray = [PopularCollectionViewCellViewModel]()
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

extension MoviePopularListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
        cell.configure(with: viewModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviewsHeaderPopularCollectionReusableView.identifier, for: indexPath) as? MoviewsHeaderPopularCollectionReusableView else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleMovie = viewModel[indexPath.item].getMovie
        delegate?.toDetailView(singleMovie: singleMovie)
    }
    
}
