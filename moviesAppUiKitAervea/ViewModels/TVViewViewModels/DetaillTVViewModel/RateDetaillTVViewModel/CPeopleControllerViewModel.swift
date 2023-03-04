//
//  CPeopleControllerViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 14.02.2023.
//

import UIKit

protocol CPeopleControllerViewModelDelegate: AnyObject {
    func reladCollection()
}

final class CPeopleControllerViewModel {
    enum CPeopleControllerViewModelType {
        case movie
        case tv
    }
    //MARK: - Properties
    weak var delegate: CPeopleControllerViewModelDelegate?
    let type: CPeopleControllerViewModelType
    var movieId: Int?
    var movieActors: [Cast] = [] {
        didSet {
            delegate?.reladCollection()
        }
    }
    var actorNAme: String {
        return ""
    }
    init(movieId: Int? = nil, type: CPeopleControllerViewModelType) {
        self.type = type
        self.movieId = movieId
      fetchData()
    }
    //MARK: - funcs
    //MARK: - Public
    public func numberOfItemsInSection() -> Int {
        
        print("DEBAG: ", movieActors.count)
        return movieActors.count
    }
    public func getCurenItem(index: Int) -> Cast {
        return movieActors[index]
    }
    //MARK: - Private
    private func fetchData() {
        switch type {
        case .movie:
            fechActorsMovies()
        case .tv:
            fechActorsTV()

        }
    }
    private func fechActorsMovies() {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: ["\(movieId ?? 0)", "credits"], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: ActorsModel.self) { [weak self] result in
            switch result {
                
            case .success(let actors):
                self?.movieActors = actors.cast ?? []
        
            case .failure(let error):
                print(error)
            }
            
        }
    }
    private func fechActorsTV() {
       Service.shared.execute(Request(endPoint: .tv, pathComponnents: ["\(movieId ?? 0)", "credits"], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: ActorsModel.self) { [weak self] result in
           switch result {
               
           case .success(let actors):
               self?.movieActors = actors.cast ?? []

           case .failure(let error):
               print(error)
           }
           
       }
   }
}
