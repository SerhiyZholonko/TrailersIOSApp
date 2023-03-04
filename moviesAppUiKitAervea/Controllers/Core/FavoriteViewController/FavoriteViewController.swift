//
//  ProfileViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    //MARK: - Properties
        let viewModel: FavoriteListViewModel
        lazy var topBarView: TopBar = {
            let view = viewModel.topBar
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK: - Init
        init(viewModel: FavoriteListViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            view.addSubview(topBarView)
            view.addSubview(collectionView)
            addConstraints()
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
                
                collectionView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
                collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)

            ])
        }

}


//MARK: - ex UICollectionViewDelegate, UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        cell.delegate = self
        cell.movie = viewModel.pMovies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (view.frame.width - 30) / 2
        return CGSize(width: size, height: size * 1.5)
    }
}


//MARK: - Delegate

extension FavoriteViewController: FavoriteCellDelegate {
    func didTapLike(cell: FavoriteCell) {
        viewModel.didTapLike(cell: cell) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
      
    }
    
   
    
    
}
