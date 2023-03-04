//
//  MorePopularShowViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.02.2023.
//

import UIKit

class MorePopularShowViewController: UIViewController {
    var popularList: MorePopularTVView
    init(popularList: MorePopularTVView) {
        self.popularList = popularList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(didTappedSearch))
        navigationController?.navigationBar.tintColor = .black
        self.popularList.delegate = self
        view.addSubview(popularList)
        addConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //MARK: -  Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            popularList.topAnchor.constraint(equalTo: view.topAnchor),
            popularList.leftAnchor.constraint(equalTo: view.leftAnchor),
            popularList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popularList.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    //Selector
  
    @objc private func didTappedSearch() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        DispatchQueue.main.async {
            searchVC.modalTransitionStyle = .crossDissolve
            self.present(searchVC, animated: true)
        }
    }

}



//MARK: - ex MorePopularTVViewDelegate

extension MorePopularShowViewController: MorePopularTVViewDelegate {
    func toDetaillViewController(singleTVShow: SinglePopularShow) {
        navigationController?.pushViewController(TVPopularDetailViewController(viewModel: TVPopopularDetailViewModel(movie: singleTVShow)), animated: true)
    }
}




//MARK: - ex MovieNowListViewDelegate

extension MorePopularShowViewController: MovieNowListViewDelegate {
    func toDetailView(singleMovie: NowSingleMovie) {
        navigationController?.pushViewController(MovieNowDetaillViewController(viewModel: NowDetaillViewViewModel(movie: singleMovie)), animated: true)
    }
}



//MARK: - ex SearchViewControllerDelegate
//TODO: - to mvvm
extension MorePopularShowViewController: SearchViewControllerDelegate {
    func didChangeTextField(text: String) {
        popularList.viewModel.callBack(text: text) {
            self.popularList.reloadData()

        }
        
    }
}
