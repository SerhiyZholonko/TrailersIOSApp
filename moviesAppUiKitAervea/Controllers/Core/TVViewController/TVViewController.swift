//
//  TVViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit

class TVViewController: UIViewController {

    //MARK: - Properties
    
    let viewModel: TVViewControllerViewModel
        lazy var topBarView: TopBar = {
            let view = TopBar(frame: .zero, viewModel: self.viewModel.topBarType)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var containerView: TVView = {
        let view = TVView(frame: .zero, viewModel: viewModel)
        return view
    }()
        
    //MARK: - Init
        init(viewModel: TVViewControllerViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.delegate = self
            view.backgroundColor = .systemBackground
            view.addSubview(topBarView)
            view.addSubview(containerView)
            addConstraints()
            containerView.collectionView?.delegate = self
            containerView.collectionView?.dataSource = self
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    //MARK: - Private

        
        private func addConstraints() {
            NSLayoutConstraint.activate([
                topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                topBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
                topBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
                topBarView.heightAnchor.constraint(equalToConstant: 50),
                
                containerView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
                containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                containerView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
            
        }


}


//MARK: - uicollectionview

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            
        case .top:
            return 8
        case .popular:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            
        case .top(viewModel: let viewModel):
            if indexPath.item <= 6 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTVCollectionViewCell.identifier, for: indexPath) as? TopTVCollectionViewCell else { return UICollectionViewCell() }
                let viewModel = viewModel[indexPath.item]
                cell.configureCell(with: viewModel)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as? MoreCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
          
        case .popular(viewModel: let viewModel):
            if indexPath.item <= 6 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularTVCollectionViewCell.identifier, for: indexPath) as? PopularTVCollectionViewCell else { return UICollectionViewCell() }
                let viewModelSingle = viewModel[indexPath.item]
                cell.configureCell(with: viewModelSingle)
                return cell
            } else {
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
           
        case .top(viewModel: let viewModel):
            if indexPath.item <= 6 {
                print("Top")
                let singleViewModel = viewModel[indexPath.item]
                navigationController?.pushViewController(TVNowDetailViewController(viewModel: TVNowDetaillViewModel(movie: singleViewModel.publicTVShow)), animated: true)
                
//                (MovieDetaillTwoViewController(viewModel: RateDetaillTVViewModel(movie: singleViewModel.publicTVShow)), animated: true)
            } else {
                    print("More")
                navigationController?.pushViewController(MoreTopTVShowViewController(nowList: MoreTopListView(frame: .zero, viewModel: viewModel)), animated: true)
                }
        case .popular(viewModel: let viewModel):
            if indexPath.item <= 6 {
                print("Popular")
                let singleViewModel = viewModel[indexPath.item]
                navigationController?.pushViewController(TVPopularDetailViewController(viewModel: TVPopopularDetailViewModel(movie: singleViewModel.publicTVShow)), animated: true)
            } else {
                    navigationController?.pushViewController(MorePopularShowViewController(popularList: MorePopularTVView(frame: .zero, viewModel: viewModel)), animated: true)
                    print("More")
                }
        }
    }
    
    
}



//MARK: - ex TVViewControllerViewModelDelegate
extension TVViewController: TVViewControllerViewModelDelegate {
    func showAlert(wit error: ServiceError) {
        self.presentAlertViewController(with: AlertViewModel(alert: AlertModel(title: "Error", massage: error.title, buttonTitle: "Dismiss")))
    }
    
    
}
