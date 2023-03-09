//
//  MoreTopListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

protocol MoreTopListViewModelDelegate: AnyObject {
    func toDetaillView(singleTVShow: SingleTopShow)
    func reloadCollectionView()
    func startSpiner()
}

final class MoreTopListViewModel: NSObject {
    weak var delegate: MoreTopListViewModelDelegate?
    var viewModel: [RateTVCollectionViewCellModel] = []
    var refreshMovies: [RateTVCollectionViewCellModel] = []
    var page = 2
    private var isLoadingMoreMovies = false

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
    private func fetchNowMovie() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["top_rated",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "\(page)")]), exepting: TopRateTVShows.self) { [weak self] result in
            print(result)
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
                for movie in singleMovies {
                    let newNowMovie = RateTVCollectionViewCellModel(movie: movie)
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

extension MoreTopListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTVCollectionViewCell.identifier, for: indexPath) as! TopTVCollectionViewCell
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
        let width = (bounds.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

            return .init(width: collectionView.frame.height, height: 100)


    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleTVShow = viewModel[indexPath.item].publicTVShow
        delegate?.toDetaillView(singleTVShow: singleTVShow)
    }
    
}

