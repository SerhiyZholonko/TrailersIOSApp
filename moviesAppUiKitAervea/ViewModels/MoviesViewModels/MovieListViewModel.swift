//
//  MovieListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit


protocol MovieListViewModelDelegate: AnyObject {
    func reloadCollection()
    func showAlert(wit error: ServiceError)
}
final class MovieListViewModel {
    
    
    enum SectionType {
        case trailer(viewModel: TrailerCollectionViewCellViewModel)
        case now(viewModel: [NowCollectionViewCellViewModel])
        case popular(viewModel: [PopularCollectionViewCellViewModel])
    }
    //MARK: - Properties
    //MARK: - Public
    weak var delegate: MovieListViewModelDelegate?
    public var sections: [SectionType] = []
    public var topBar: TopBarViewModel? {
        return topBarViewModel
    }
    public var nowCount: Int {
        return 3
    }
    public var trailerCount: Int {
        return 1
    }
    public var popularCount: Int {
        return 6
    }
    //MARK: - Private
    var nowMovies: [NowSingleMovie] = [] {
        didSet {
            var nowViewModel: [NowCollectionViewCellViewModel] = []
            for singleMovie in nowMovies {
                let viewModel = NowCollectionViewCellViewModel(movie: singleMovie)
                nowViewModel.append(viewModel)
            }
            sections.append(.now(viewModel: nowViewModel))
        }
    }
    var popularMovies: [SingleMovie] = [] {
        didSet {
            var popularViewModel: [PopularCollectionViewCellViewModel] = []
            for singleMovie in popularMovies {
                let viewModel = PopularCollectionViewCellViewModel(movie: singleMovie)
                popularViewModel.append(viewModel)
            }
            sections.append(.popular(viewModel: popularViewModel))
        }
    }
    
    private let topBarViewModel: TopBarViewModel?
    //MARK: - init
    init(topBarViewModel: TopBarViewModel? = nil) {
        self.topBarViewModel = topBarViewModel
        setupSection()
    }
    
    //MARK: public
    public func updataNowMovies(resultSearch: [NowSingleMovie]) {
        self.sections = [
            .trailer(viewModel: TrailerCollectionViewCellViewModel(image: UIImage(named: "Oval"))),
            
            
        ]
        self.nowMovies = resultSearch
        var nowViewModel: [NowCollectionViewCellViewModel] = []
        for singleMovie in nowMovies {
            let viewModel = NowCollectionViewCellViewModel(movie: singleMovie)
            nowViewModel.append(viewModel)
        }
        sections.append(.now(viewModel: nowViewModel))
        
        fetchPopularMovie()
        
    }
//    func setupSection() {
//        fetchNowMovie() { [weak self] in
//            self?.fetchPopularMovie()
//        }
//        
//        self.sections = [        .trailer(viewModel: TrailerCollectionViewCellViewModel(image: UIImage(named: "Oval"))),    ]
//    }

//    func fetchNowMovie(completion: @escaping () -> Void) {
//        // Perform asynchronous operation to fetch now movies
//        // ...
//
//        // When done, call the completion handler
//        completion()
//    }
//    func setupSection() {
//        let group = DispatchGroup()
//
//        group.enter()
//        fetchNowMovie {
//            group.leave()
//        }
//
//        group.notify(queue: DispatchQueue.main) { [weak self] in
//            self?.fetchPopularMovie()
//
//            self?.sections = [            .trailer(viewModel: TrailerCollectionViewCellViewModel(image: UIImage(named: "Oval"))),        ]
//        }
//    }
//    func setupSection() {
//        fetchPopularMovie() { [weak self] in
//            self?.fetchNowMovie()
//
//            self?.sections = [            .trailer(viewModel: TrailerCollectionViewCellViewModel(image: UIImage(named: "Oval"))),        ]
//        }
//    }

//    func fetchPopularMovie(completion: @escaping () -> Void) {
//        // Perform asynchronous operation to fetch popular movies
//        // ...
//
//        // When done, call the completion handler
//        completion()
//    }
//
//    func fetchNowMovie(completion: @escaping () -> Void) {
//        // Perform asynchronous operation to fetch now movies
//        // ...
//
//        // When done, call the completion handler
//        DispatchQueue.main.async {
//            completion()
//        }
//    }
    func setupSection() {
        fetchNowMovie()
        fetchPopularMovie()

        self.sections = [
            .trailer(viewModel: TrailerCollectionViewCellViewModel(image: UIImage(named: "Oval"))),
        ]
    }
    //MARK: private
    private func fetchNowMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["now_playing",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: NowMovies.self) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
                self?.nowMovies = singleMovies
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.reloadCollection()
                }
            case .failure(let error):
                self?.delegate?.showAlert(wit: error)
                print(error)
            }
            
        }
    }
    private func fetchPopularMovie() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["popular",], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5"), URLQueryItem(name: "page", value: "1")]), exepting: Movie.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
                
            case .success(let movies):
                guard let singleMovies = movies.results else { return }
                if !strongSelf.popularMovies.contains(singleMovies) {
                    strongSelf.popularMovies = singleMovies
                }
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.reloadCollection()
                }
            case .failure(let error):
                strongSelf.delegate?.showAlert(wit: error)
                print("Error: ",error)
            }
            
        }
    }
    
    


    
    
    //MARK: - layout
    
    public func createTrailerSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
        
        
    }
    public func createNowSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(225)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Now", alignment: .top)
            
        ]
        return section
    }
    public func createPopularSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(450)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Popular", alignment: .top)
            
        ]
        return section
    }
    
}
