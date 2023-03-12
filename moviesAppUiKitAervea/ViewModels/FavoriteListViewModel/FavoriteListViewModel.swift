//
//  FavoriteListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.03.2023.
//

import Foundation

final class FavoriteListViewModel {
    let topBar = TopBar(frame: .zero, viewModel: .init(type: .profile))
    
    public var pMovies: [CDMovie] {
        return CoreDataManager.shared.fetchData(entityName: "CDMovie")
    }
    
    public func getImageData() -> Data? {
        let users: [CDProfile] = CoreDataManager.shared.fetchData(entityName: "CDProfile")
        let user = users.first
        return user?.imageData
    }
    public func getUserName() -> String? {
        let users: [CDProfile] = CoreDataManager.shared.fetchData(entityName: "CDProfile")
        let user = users.first
        return user?.userName
    }
    public func setName(name: String) -> String {
        return name
    }
    public func isNoEmptyEditText(text: String) -> Bool {
        if text != "" {
            return true
        } else {
           return false
        }
    }
    
    public func moviesCount() -> Int {
        pMovies.count
    }
    public func isEmptyMovies() -> Bool {
        if pMovies.count == 0 {
           return true
        } else {
           return false
        }
    }
    func didTapLike(cell: FavoriteCell, complition: @escaping () -> Void) {
        guard let movie = cell.movie else { return }
        guard let index = pMovies.firstIndex(of: movie ) else { return }
        let movieToDelete = pMovies[index]
        if let title = movieToDelete.title {
            DataService.shared.setFavoriteStatus(for: title, with: false)
        }
        CoreDataManager.shared.delete(movieToDelete)
        CoreDataManager.shared.saveContext()
        NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)

     complition()
    }
    
}
