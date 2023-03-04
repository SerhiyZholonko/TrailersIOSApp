//
//  DataService.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 22.02.2023.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setFavoriteStatus(for buttonName: String, with status: Bool) {
        userDefaults.set(status, forKey: buttonName)
    }
    
    func getFavoriteStatus(for buttonName: String) -> Bool {
        userDefaults.bool(forKey: buttonName)
    }
}
