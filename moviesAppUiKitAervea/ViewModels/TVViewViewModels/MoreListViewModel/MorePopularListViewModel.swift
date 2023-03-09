//
//  MorePopularListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

protocol MorePopularListViewModelDelegate: AnyObject {
    func toDetaillView(singleTVShow: SinglePopularShow)
    func reloadCollectionView()
    func startSpiner()
}

final class MorePopularListViewModel: NSObject {
    weak var delegate: MorePopularListViewModelDelegate?
    var viewModel: [PopularTVCollectionViewCellModel] = []
    var refreshMovies: [PopularTVCollectionViewCellModel] = []
    var page = 2
    private var isLoadingMoreMovies = false
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
    private func fetchNowMovie() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["popular",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "\(page)")]), exepting: PopularTVShows.self) { [weak self] result in
            print(result)
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
                for movie in singleMovies {
                    let newNowMovie = PopularTVCollectionViewCellModel(movie: movie)
                    self?.viewModel.append(newNowMovie)
                }
                print("Count1: ", self?.viewModel.count)
                self?.delegate?.reloadCollectionView()
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print(error)
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 1 {
            page += 1
            fetchNowMovie()
//            delegate?.reloadCollectionView()
        }
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
