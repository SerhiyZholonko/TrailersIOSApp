//
//  TVViewControllerViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 06.02.2023.
//

import UIKit

protocol TVViewControllerViewModelDelegate: AnyObject {
    func showAlert(wit error: ServiceError)
}

final class TVViewControllerViewModel {
    //MARK: - Properties
    enum SectionType {
        case top(viewModel: [RateTVCollectionViewCellModel])
        case popular(viewModel: [PopularTVCollectionViewCellModel])
    }
   //MARK: - Public
    weak var delegate: TVViewControllerViewModelDelegate?
    public var sections = [SectionType]()
    let topBarType: TopBarViewModel
    init(topBarType: TopBarViewModel) {
        self.topBarType = topBarType
        setupSection()
    }
    //MARK: - Private
    lazy var topTVShows: [SingleTopShow] = [] {
         didSet {
             var topViewModel: [RateTVCollectionViewCellModel] = []
             for singleMovie in topTVShows {
                 let viewModel = RateTVCollectionViewCellModel(movie: singleMovie)
                 topViewModel.append(viewModel)
             }
             sections.append(.top(viewModel: topViewModel))
         }
     }
    lazy var popularTVShows: [SinglePopularShow] = [] {
         didSet {
             var popularViewModel: [PopularTVCollectionViewCellModel] = []
             for singleMovie in popularTVShows {
                 let viewModel = PopularTVCollectionViewCellModel(movie: singleMovie)
                 popularViewModel.append(viewModel)
             }
             sections.append(.popular(viewModel: popularViewModel))
         }
     }
    private func setupSection() {
        fetchTopMovie()
        fetchPopularMovie()
        self.sections = [
           

            
        ]
    }
    
    //MARK: - func
    //MARK: - Private
    
    private func fetchTopMovie() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["top_rated",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: TopRateTVShows.self) { result in
            switch result {
                
            case .success(let movies):
                guard let singleTVShows = movies.results else { return }
                self.topTVShows = singleTVShows
            case .failure(let error):
                self.delegate?.showAlert(wit: error)
            }
            
        }
    }
    private func fetchPopularMovie() {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["popular",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: PopularTVShows.self) { result in
            switch result {
                
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
                self.popularTVShows = singleMovies
            case .failure(let error):
                print(error)
            }
            
        }
    }
    //MARK: - layout
    public func createNowSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Now", alignment: .top)
            
        ]
        return section
    }
    public func createPopularSectionLayout() -> NSCollectionLayoutSection {
       
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Popular", alignment: .top)
            
        ]
        return section
    }
}
