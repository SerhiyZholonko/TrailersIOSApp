//
//  SendTextView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 01.03.2023.
//

import UIKit

class SendTextView: UIView {
    
    //MARK: - Properties
    let textField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Say something…"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let underscorView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        addSubview(underscorView)
        addSubview(sendButton)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Private func
    private func addConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            underscorView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            underscorView.leftAnchor.constraint(equalTo: textField.leftAnchor),
            underscorView.rightAnchor.constraint(equalTo: textField.rightAnchor),
            underscorView.heightAnchor.constraint(equalToConstant: 2),
            
            sendButton.topAnchor.constraint(equalTo: textField.topAnchor),
            sendButton.leftAnchor.constraint(equalTo: textField.rightAnchor),
            sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            sendButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1),
            
        ])
    }
    
}
