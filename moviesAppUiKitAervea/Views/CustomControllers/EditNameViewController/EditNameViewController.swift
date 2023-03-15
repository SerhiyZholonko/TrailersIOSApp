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
    lazy var okButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.tintColor = .systemGreen
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didOkButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var canselButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.tintColor = .systemRed
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didCanselTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(editTextField)
        view.addSubview(okButton)
        view.addSubview(canselButton)
        addConstraints()
        setupDismiss()
    }
    
    //Private
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            editTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            editTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            editTextField.heightAnchor.constraint(equalToConstant: 50),
            editTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            okButton.topAnchor.constraint(equalTo: editTextField.bottomAnchor, constant: 10),
            okButton.leftAnchor.constraint(equalTo: editTextField.leftAnchor, constant: 10),
            okButton.widthAnchor.constraint(equalToConstant: 40),
            okButton.heightAnchor.constraint(equalToConstant: 40),
            
            canselButton.topAnchor.constraint(equalTo: editTextField.bottomAnchor, constant: 10),
            canselButton.rightAnchor.constraint(equalTo: editTextField.rightAnchor, constant: -10),
            canselButton.widthAnchor.constraint(equalToConstant: 40),
            canselButton.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
    private func setupDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        view.addGestureRecognizer(tap)
    }
    
    //Selector
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    @objc private func didOkButtonTapped() {
        dismiss(animated: true)
        guard let text = editTextField.text else { return }
        delegate?.bringText(text: text)
    }
    @objc private func didCanselTapped() {
        dismiss(animated: true)
    }
}
