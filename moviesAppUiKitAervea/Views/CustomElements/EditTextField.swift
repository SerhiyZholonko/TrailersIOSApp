//
//  EditTextField.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.03.2023.
//
import UIKit

class EditTextField: UITextField {
    // Set padding for text field
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Customization code
    private func setupView() {
        self.placeholder = "Enter your name"
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 2
        // Set border style
        self.borderStyle = .roundedRect
        // Set border color
        self.layer.borderColor = UIColor.gray.cgColor
        // Set border width
        self.layer.borderWidth = 1.0
    }
    
    // Override text rectangle method to add padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Override editing rectangle method to add padding
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Override placeholder position method to add padding
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
