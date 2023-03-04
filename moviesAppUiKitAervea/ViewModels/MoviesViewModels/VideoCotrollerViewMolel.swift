//
//  VideoCotrollerViewMolel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 23.02.2023.
//

import Foundation

public class VideoViewControllerViewModel {
    
    var singleTrailer: SingleTrailer?
    let id: String
    init(singleTrailer: SingleTrailer? = nil, id: String) {
        self.singleTrailer = singleTrailer
        self.id = id
    }
    func fetchTrailerMovies(idMovie: String, complition: @escaping (String) -> Void) {
        Service.shared.execute(Request(endPoint: .movie, pathComponnents: [id, "videos"], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: TrailerModel.self) { result in
            switch result {
            case .success( let curentTrailer):
                if let result = curentTrailer.results {
                    guard let last = result.last else { return }
                    guard let key = last.key else { return }
                    complition(key)
                }
            case .failure(_):
                break
            }
        }
        
    }
    func fetchTrailerTVShows(idMovie: String, complition: @escaping (String) -> Void) {
        Service.shared.execute(Request(endPoint: .tv, pathComponnents: [id, "videos"], queryParammeters: [URLQueryItem.init(name: "api_key", value: "8983d582e6db4d50746d8e03ec9e79f5")]), exepting: TrailerModel.self) { result in
            switch result {
            case .success( let curentTrailer):
                if let result = curentTrailer.results {
                    guard let last = result.last else { return }
                    guard let key = last.key else { return }
                    complition(key)
                }
            case .failure(_):
                break
            }
        }
        
    }
}
