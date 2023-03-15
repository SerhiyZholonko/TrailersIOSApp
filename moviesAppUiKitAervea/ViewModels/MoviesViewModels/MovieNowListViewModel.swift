//
//  MovieNowListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit


protocol MovieNowListViewModelDelegate: AnyObject {
    func toDetailController(singleMovie: NowSingleMovie)
    func reloadCollectionView()
    func startSpiner()
}
final class MovieNowListViewModel: NSObject {
    weak var delegate: MovieNowListViewModelDelegate?
    var viewModel: [NowCollectionViewCellViewModel] = []
    var refreshMovies: [NowCollectionViewCellViewModel] = []
//    var nowMovies: [NowCollectionViewCellViewModel] = []
    var apiInfo: NowMovies? = nil
    var page = 2
    private var isLoadingMoreMovies = false
    init(nowMovies: [NowCollectionViewCellViewModel]) {
        self.refreshMovies = nowMovies
        self.viewModel = nowMovies
        super.init()

        fetchNowMovie()
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
    private func fetchNowMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["now_playing",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "\(page)")]), exepting: NowMovies.self) { [weak self] result in
            print(result)
            switch result {
            case .success(let movies):
                self?.apiInfo = movies
                guard let singleMovies = movies.results else { return }
                for movie in singleMovies {
                    let newNowMovie = NowCollectionViewCellViewModel(movie: movie)
                    self?.viewModel.append(newNowMovie)
                }
                self?.delegate?.reloadCollectionView()
            case .failure(let error):
//                self?.delegate?.showAlert(wit: error)
                print(error)
            }
            
        }
    }

}

//MARK: - CollsectionView
extension MovieNowListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.identifier, for: indexPath) as! NowCollectionViewCell
       
            cell.configure(with: viewModel[indexPath.item])
          
        
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
        let width = (collectionView.frame.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviewsHeaderNowCollectionReusableView.identifier, for: indexPath) as? MoviewsHeaderNowCollectionReusableView else { return UICollectionReusableView() }
            return header
            case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MoViewNowListViewUnderCollevtionViewSpiner.identifier, for: indexPath) as? MoViewNowListViewUnderCollevtionViewSpiner else { return UICollectionReusableView() }
            footer.startSpiner()
            return footer
            default:
                fatalError("Unexpected supplementary view kind: \(kind)")
            }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

            return .init(width: collectionView.frame.height, height: 100)


    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleMovie = viewModel[indexPath.item].getMovie
        delegate?.toDetailController(singleMovie: singleMovie)
    }
    
    
    
    
}



    

    

