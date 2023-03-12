//
//  EditNameViewController.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 12.03.2023.
//

import UIKit

protocol EditNameViewControllerDelegate: AnyObject {
    func bringText(text: String)
}

class EditNameViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: EditNameViewControllerDelegate?
    let editTextField: EditTextField = {
        let tf = EditTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(editTextField)
        addConstraints()
        setupDismiss()
    }
    
    //Private
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            editTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            editTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            editTextField.heightAnchor.constraint(equalToConstant: 50),
            editTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    private func setupDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        view.addGestureRecognizer(tap)
    }
    
    //Selector
    @objc private func didTapDismiss() {
        dismiss(animated: true)
        guard let text = editTextField.text else { return }
        delegate?.bringText(text: text)
    }

    
    
    
    
}
