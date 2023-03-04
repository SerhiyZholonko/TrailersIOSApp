//
//  SearchView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 19.02.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didChangeText(text: String)
}

class SearchView: UIView {
    //Properties
    weak var delegate: SearchViewDelegate?
    let searchTextField: SearchTextField = {
        let textField = SearchTextField(frame: .zero, viewModel: SearchTextFieldViewModle(textFieldPlaceolder: "Search", imageName: "magnifyingglass"))
        return textField
    }()
  //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchTextField)
        addConstraints()
        searchTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: leftAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTextField.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}


//MARK: - ex SearchView to UITextFieldDelegate

extension SearchView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let stringText = textField.text else { return }
        delegate?.didChangeText(text: stringText)
    }
}
