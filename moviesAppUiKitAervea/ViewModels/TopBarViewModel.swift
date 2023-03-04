//
//  TopBarViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 29.01.2023.
//

import UIKit


struct TopBarViewModel {
    var movieTitle: String {
        return type.title
    }
    var shearchImage: UIImage? {
        return type.buttonImage
    }
    enum TopBarType {
        case movie
        case tv
        case favorite
        
        var title: String {
            switch self {
            case .movie:
                return "Movies".uppercased()
            case .tv:
                return "TV".uppercased()
            case .favorite:
                return "Favorite".uppercased()
            }
        }
        var buttonImage: UIImage? {
            switch self {
            case .movie:
                return UIImage(named: "searchIcon")
            case .tv:
                return UIImage(named: "searchIcon")
            case .favorite:
                return UIImage(named: "searchIcon")
            }
        }
    }
    
    let type: TopBarType
    init(type: TopBarType) {
        self.type = type
    }
}
