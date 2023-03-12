//
//  ProfileViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController, UITabBarControllerDelegate {

    //MARK: - Properties
        let viewModel: FavoriteListViewModel
        lazy var topBarView: TopBar = {
            let view = viewModel.topBar
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    lazy var profileView: ProfileView = {
       let view = ProfileView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)

        collectionView.register(FavoriteCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoriteCollectionReusableView.identifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Please, add you favorite movies".uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
            profileView.delegate = self
            view.backgroundColor = .systemBackground
            view.addSubview(topBarView)
            view.addSubview(profileView)
            view.addSubview(collectionView)
            view.addSubview(emptyLabel)
            addConstraints()
            guard let imageData = viewModel.getImageData() else { return }
            profileView.userImage.image = UIImage(data: imageData)
            guard let userName = viewModel.getUserName() else { return }
            profileView.userLabel.text = userName
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: true)
            collectionView.reloadData()

        }
    //MARK: - Private

        
        private func addConstraints() {
            NSLayoutConstraint.activate([
                topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                topBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
                topBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
                topBarView.heightAnchor.constraint(equalToConstant: 50),
                
                profileView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
                profileView.leftAnchor.constraint(equalTo: view.leftAnchor),
                profileView.rightAnchor.constraint(equalTo: view.rightAnchor),
                profileView.heightAnchor.constraint(equalToConstant: 200),
                
                collectionView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
                collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                
                emptyLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
                emptyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                emptyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)

            ])
        }

}


//MARK: - ex UICollectionViewDelegate, UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isEmptyMovies() {
            emptyLabel.alpha = 1
        } else {
            emptyLabel.alpha = 0
        }
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavoriteCollectionReusableView.identifier, for: indexPath) as! FavoriteCollectionReusableView
            // Configure your header view here
            return headerView
        default:
            fatalError("Invalid supplementary view type")
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
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


//MARK: - ImagePiker

extension FavoriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let user = CDProfile(context: CoreDataManager.shared.managedObjectContext)
       
        user.userName = profileView.userLabel.text
        user.imageData = selectedImage.pngData()
        CoreDataManager.shared.deleteAllEntities(entityName: "CDProfile")
        CoreDataManager.shared.save(user)
        profileView.setImage(with: selectedImage)
        
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - ProfileView delegate

extension FavoriteViewController: ProfileViewDelegate {
    func didEditButtonTapped() {
        let vc = EditNameViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
  
    func didImageViewTapped() {
        let imagePiker = UIImagePickerController()
        imagePiker.delegate = self
        self.present(imagePiker, animated: true)
    }
    
    
}


//MARK: - EditNameViewControllerDelegate

extension FavoriteViewController: EditNameViewControllerDelegate {
    func bringText(text: String) {
        guard viewModel.isNoEmptyEditText(text: text) else { return }
        self.profileView.userLabel.text = viewModel.setName(name: text)
        
        let user = CDProfile(context: CoreDataManager.shared.managedObjectContext)
       
        user.userName = viewModel.setName(name: text)
        user.imageData = profileView.userImage.image?.pngData()
        CoreDataManager.shared.deleteAllEntities(entityName: "CDProfile")
        CoreDataManager.shared.save(user)
        
    }
    
  
    
    
}
