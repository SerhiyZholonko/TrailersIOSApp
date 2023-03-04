//
//  Constants.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.01.2023.
//

import UIKit


class Constants {
    enum WalkthroughImageName: String {
        case WalkthroughImageOne
        case WalkthroughImageTwo
        case WalkthroughImageThree
    
        var getImageName: String {
            switch self {
            case .WalkthroughImageOne:
                return "WalkthroughImageOne"
            case .WalkthroughImageTwo:
                return "WalkthroughImageTwo"
            case .WalkthroughImageThree:
                return "WalkthroughImageThree"
            }
        }
        var getGradient: String {
            switch self {
            case .WalkthroughImageOne:
                return "WalkthroughGradientOne"
            case .WalkthroughImageTwo:
                return "WalkthroughGradientTwo"
            case .WalkthroughImageThree:
                return "WalkthroughGradientThree"
            }
        }
    }
}
