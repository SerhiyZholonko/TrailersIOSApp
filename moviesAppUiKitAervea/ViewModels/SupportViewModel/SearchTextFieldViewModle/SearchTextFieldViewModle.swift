//
//  SearchTextFieldViewModle.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 19.02.2023.
//

import UIKit


struct SearchTextFieldViewModle {
    //MARK: - Properties
    public var image: UIImage? {
        return UIImage(named: imageName)
    }
    public var palaceholder: String {
        return textFieldPlaceolder
    }
    
    public let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let textFieldPlaceolder: String
    private let imageName: String
    init(textFieldPlaceolder: String, imageName: String) {
        self.textFieldPlaceolder = textFieldPlaceolder
        self.imageName = imageName
    }
}
