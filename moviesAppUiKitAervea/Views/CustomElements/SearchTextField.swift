//
//  SearchTextField.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 19.02.2023.
//

import UIKit

class SearchTextField: UITextField {
    //MARK: Properties
    let viewModel: SearchTextFieldViewModle
  
    //MARK: - init
    init(frame: CGRect, viewModel: SearchTextFieldViewModle) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configure()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override text rectangle method to add padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }

    // Override editing rectangle method to add padding
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }

    // Override placeholder position method to add padding
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }
    //MARK: - Private func
    private func configure() {
        backgroundColor = .secondarySystemBackground
             // Set border color
             self.layer.borderColor = UIColor.gray.cgColor
             // Set border width
             self.layer.borderWidth = 1.0
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor =  UIColor.gray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupTextField() {
        DispatchQueue.main.async {
            self.placeholder = self.viewModel.palaceholder
        }
    }
}
