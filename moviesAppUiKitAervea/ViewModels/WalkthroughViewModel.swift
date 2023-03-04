//
//  WalkthroughViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 27.01.2023.
//

import UIKit

struct WalkthroughViewModel {
    public var title: String {
        return type.title
    }
    public var subInfo: String {
        return type.subInfo
    }
    public var progresImage: UIImage? {
        return type.progresImage
    }
    public var buttonTitle: String {
        return type.buttonTitle
    }
    public var buttonImage: UIImage? {
        return type.buttonImage
    }
    public var backgroundColor: UIColor? {
        return type.backgroundColor
    }
    enum WalkthroughViewType {
        case first
        case second
        case finish
        
        var title: String {
            switch self {
            case .first:
                return "Get the first"
            case .second:
                return "Know the movie"
            case .finish:
                return "Real-time"
            }
        }
        var subInfo: String {
                switch self {
                case .first:
                    return "Movie &TV information"
                case .second:
                    return "is not worth Watching"
                case .finish:
                    return "updates movie Trailer"
                }
            }
        var progresImage: UIImage? {
                switch self {
                case .first:
                    return UIImage(named: "pages1")
                case .second:
                    return UIImage(named: "pages2")
                case .finish:
                    return UIImage(named: "pages3")
                }
            }
        var buttonTitle: String {
                switch self {
                case .first:
                    return "Next  "
                case .second:
                    return "Next  "
                case .finish:
                    return "Get Stared"
                }
            }
        var buttonImage: UIImage? {
                switch self {
                case .first:
                    return UIImage(named: "whiteArrow")
                case .second:
                    return UIImage(named: "whiteArrow")
                case .finish:
                    return nil
                }
            }
        var backgroundColor: UIColor? {
            switch self {
            case .first:
               return nil
            case .second:
               return nil
            case .finish:
               return .orange
            }
        }
            
    }
    let type: WalkthroughViewType
    init(type: WalkthroughViewType) {
        self.type = type
    }
}
