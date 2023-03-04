//
//  Service.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 07.02.2023.
//

import Foundation


final class Service {
    //MARK: - Pproperties
    static let shared = Service()
    
    private init() {}
    //MARK: - Public
    public func execute<T: Codable>(_ mRequest: Request,
                                        exepting type: T.Type,
                                        completion: @escaping (Result<T, ServiceError>) -> Void){
            guard let urlRequest = self.request(from: mRequest) else {
                completion(.failure(ServiceError.failedToCreateRequest))
                return
            }
            let tasck = URLSession.shared.dataTask(with: urlRequest) { data, _, err in
                guard let data = data, err == nil else  {
                    completion(.failure(.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.failedToCreateRequest))
                }
            }
            tasck.resume()
        }
        
    public  func request(from request: Request) -> URLRequest? {
            guard let url = request.url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = request.httpMethod
            return request
        }
    
}
