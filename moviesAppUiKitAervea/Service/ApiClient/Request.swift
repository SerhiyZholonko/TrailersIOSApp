//
//  Request.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 07.02.2023.
//

import Foundation


final class Request {
    private struct Constants {
        static let baseUrl = "https://api.themoviedb.org"
        
    }
    private let endPoint: Endpoint
    private let pathComponnents: [String]
    
    private let queryParammeters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/3/"
        string += endPoint.rawValue

        if !pathComponnents.isEmpty {
            pathComponnents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParammeters.isEmpty {
            string += "?"
            let argumentString = queryParammeters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }
    public var url: URL? {
        return URL(string: urlString)
    }
    public let httpMethod = "GET"
    public init(endPoint: Endpoint, pathComponnents: [String] = [], queryParammeters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponnents = pathComponnents
        self.queryParammeters = queryParammeters
    }
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0] // Endpoint
                let queryItemString = components[1]
                let queryItem: [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap {
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                }
                
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = Endpoint(
                    rawValue: endpointString
                ) {
                    self.init(endPoint: rmEndpoint, queryParammeters: queryItem)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let rmEndpoint = Endpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint, queryParammeters: queryItems)
                    return
                }
            }
        }

        return nil
    }

}
