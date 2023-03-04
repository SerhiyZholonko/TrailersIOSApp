//
//  FavoriteListViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.03.2023.
//

import Foundation

struct FavoriteListViewModel {
    let topBar = TopBar(frame: .zero, viewModel: .init(type: .favorite))
    
    public var pMovies: [CDMovie] {
        return CoreDataManager.shared.fetchData(entityName: "CDMovie")
    }
    
    func didTapLike(cell: FavoriteCell, complition: @escaping () -> Void) {
        guard let movie = cell.movie else { return }
        guard let index = pMovies.firstIndex(of: movie ) else { return }
        let movieToDelete = pMovies[index]
        CoreDataManager.shared.delete(movieToDelete)
        CoreDataManager.shared.saveContext()
     complition()
    }
    
}
