//
//  MoviesViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit
import Reachability

class MoviesViewController: UIViewController {
 
    
//MARK: - Properties
    private var viewModel = MovieListViewModel(topBarViewModel: TopBarViewModel(type: .movie))
    lazy var topBarView: TopBar = {
        let view = TopBar(frame: .zero, viewModel: viewModel.topBar ?? .init(type: .tv))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var movieListView = MovieListView(frame: .zero, viewModel: viewModel )
//MARK: - Init
    init() {
      
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(topBarView)
        view.addSubview(movieListView)
        addConstraints()
        movieListView.collectionView?.delegate = self
        movieListView.collectionView?.dataSource = self
  
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
//MARK: - Private
    @objc func keyboardWillShow(){
          print("NotificationCenter")
        DispatchQueue.main.async {
            self.movieListView.collectionView?.reloadData()
        }
      }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 50),
            
            movieListView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            movieListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieListView.rightAnchor.constraint(equalTo: view.rightAnchor),

            
        ])
    }


}
//MARK: - CollectionView
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            
        case .trailer:
            return 1
        case .now:
            return 3
        case .popular:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Now" {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:   MoviewsHeaderNowCollectionReusableView.identifier, for: indexPath) as! MoviewsHeaderNowCollectionReusableView
            return header
        } else  {
            let header =
            collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:   MoviewsHeaderPopularCollectionReusableView.identifier, for: indexPath) as! MoviewsHeaderPopularCollectionReusableView
            return header
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .trailer(let viewModel):
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionViewCell.identifier, for: indexPath) as? TrailerCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(with: viewModel)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as? MoreCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
                
            }
        case .now(viewModel: let viewModel):
            if indexPath.item <= 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.identifier, for: indexPath) as? NowCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModel[indexPath.item])
            return cell
        }
            else {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as? MoreCollectionViewCell else {
                   return UICollectionViewCell()
               }
               return cell

           }
        case .popular(viewModel: let viewModel):
            if indexPath.item <= 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModel[indexPath.item])
            return cell
        }
            else {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as? MoreCollectionViewCell else {
                   return UICollectionViewCell()
               }
               return cell

           }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .trailer:
            break
        case .now(viewModel: let viewModel):
            if indexPath.item != 2 {
                let movie = viewModel[indexPath.item].getMovie
                navigationController?.pushViewController(MovieNowDetaillViewController(viewModel: NowDetaillViewViewModel(movie: movie)), animated: true)
            } else {
                navigationController?.pushViewController(MoreNowMovieViewController(nowList: MovieNowListView(frame: .zero, viewModel: viewModel)), animated: true)
            }
            break
        case .popular(viewModel: let viewModel):
            if indexPath.item != 5 {
                let movie = viewModel[indexPath.item].getMovie

                navigationController?.pushViewController(MoviePopularDetaillViewController(viewModel: PopularDetaillViewViewModel(movie: movie)), animated: true)
            } else {
                navigationController?.pushViewController(MorePopularMovieViewController(nowList: MoviePopularListView(frame: .zero, viewModel: viewModel)), animated: true)

            }
        }
    }
    
}



//MARK: - ex MovieListViewModelDelegate
extension MoviesViewController: MovieListViewModelDelegate {
    func showAlert(wit error: ServiceError) {
        self.presentAlertViewController(with: AlertViewModel(alert: AlertModel(title: "Error", massage: error.title, buttonTitle: "Dismiss")))

    }
    func reloadCollection() {
        movieListView.collectionView?.reloadData()
    }
}


