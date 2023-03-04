//
//  SearchViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 19.02.2023.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func didChangeTextField(text: String)
}

class SearchViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: SearchViewControllerDelegate?
    let searchView: SearchView = {
        let tf = SearchView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        searchView.delegate = self
        view.addSubview(searchView)
        addConstraints()
        
    }
//MARK: - Private func
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            searchView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        dismiss(animated: true)
        print("Tap")
    }

}


//MARK: - ex SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didChangeText(text: String) {
        delegate?.didChangeTextField(text: text)
    }
    
    
}
