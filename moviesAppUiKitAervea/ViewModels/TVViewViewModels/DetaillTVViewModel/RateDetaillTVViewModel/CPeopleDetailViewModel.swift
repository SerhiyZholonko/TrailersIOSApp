//
//  CPeopleDetailViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 25.02.2023.
//

import Foundation

protocol CPeopleDetailViewModelDelegate: AnyObject {
    func reloadModel(viewModel: CPeopleDetailViewModel)
}

struct CPeopleDetailViewModel {
    //MARK: - Properties
    //MARK: - Public
    weak var delegate: CPeopleDetailViewModelDelegate?
    public let actorId: String
    
    public var name: String? {
        return actor?.name
    }
    public var bithday: String? {
        return actor?.birthday
    }
    public var gender: String? {
        guard let actor = actor else { return nil }
        switch actor.gender {
        case 1:
            return "female"
        case 2:
            return "male"
        default:
           return "gender"
        }
    }
    public var imageUrl: String {
        guard let actor = actor else { return "" }
        print("Url: ",  "https://www.themoviedb.org/t/p/original/" + actor.placeOfBirth)
        guard let supStringUrl = actor.profilePath else { return "" }
        return "https://www.themoviedb.org/t/p/original/" + supStringUrl
    }
    public var bio: String? {
        return actor?.biography
    }
    //MARK: - Private
   private var actor: ActorModel?
    //MARK: - init
    init(actorId: String) {
        self.actorId = actorId
    }
    
    //MARK: - Public
    public mutating func fetchSingleActor() {
        Service.shared.execute(Request(endPoint: .person, pathComponnents: [actorId], queryParammeters: [URLQueryItem(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: ActorModel.self) { [self] curentActor in
            var viewModel = self
            switch curentActor {
            case .success(let actor):
                viewModel.actor = actor
                delegate?.reloadModel(viewModel: viewModel)
            case .failure(_):
                break
            }
        }
    }
}




// https://api.themoviedb.org/3/person/1083010?api_key=8983d582e6db4d50746d8e03ec9e79f5&language=en-US
