//
//  MoreMovieViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 02.02.2023.
//

import UIKit

class MoreNowMovieViewController: UIViewController {
    var nowList: MovieNowListView
    init(nowList: MovieNowListView) {
        self.nowList = nowList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(didTappedSearch))
        navigationController?.navigationBar.tintColor = .black
        nowList.delegate = self
        view.addSubview(nowList)
        addConstraints()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //MARK: -  Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nowList.topAnchor.constraint(equalTo: view.topAnchor),
            nowList.leftAnchor.constraint(equalTo: view.leftAnchor),
            nowList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nowList.rightAnchor.constraint(equalTo: view.rightAnchor),
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

//MARK: - ex MovieNowListViewDelegate
extension MoreNowMovieViewController: MovieNowListViewDelegate {
    func toDetailView(singleMovie: NowSingleMovie) {
        navigationController?.pushViewController(MovieNowDetaillViewController(viewModel: NowDetaillViewViewModel(movie: singleMovie)), animated: true)
    }
}



//MARK: - ex SearchViewControllerDelegate
extension MoreNowMovieViewController: SearchViewControllerDelegate {
    func didChangeTextField(text: String) {
        nowList.viewModel.callBack(text: text) {
            self.nowList.reloadData()

        }
    }
}


