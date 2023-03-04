//
//  ReactionViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 23.02.2023.
//

import UIKit

struct ReactionViewModel {
    //MARK: - Parametters
    public var pLike: String {
        return nameMoview + "Like"
    }
    public var pComment: String {
        return nameMoview + "Comment"
    }
    public var pFavorite: String {
        return nameMoview + "Favorite"
    }
    private let nameMoview: String
    
    init(nameMoview: String) {
        self.nameMoview = nameMoview
    }
}
