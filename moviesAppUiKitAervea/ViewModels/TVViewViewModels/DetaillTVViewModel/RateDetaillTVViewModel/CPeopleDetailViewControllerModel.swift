//
//  CPeopleDetailViewControllerModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 25.02.2023.
//

import Foundation


struct CPeopleDetailViewControllerModel {
    public var pActorId: String {
        return actorId
    }
    private let actorId: String
    init(actorId: String) {
        self.actorId = actorId
    }
}
