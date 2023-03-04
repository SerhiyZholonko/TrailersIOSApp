//
//  AlertViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 17.02.2023.
//

import Foundation


final class AlertViewModel {
    //MARK: - Properties
    
    //Public
    public var title: String {
        return alert.title
    }
    public var massage: String {
        return alert.massage
    }
    public var titleButton: String {
        return alert.buttonTitle
    }
    //Private
    private let alert: AlertModel
    init(alert: AlertModel) {
        self.alert = alert
    }
}
