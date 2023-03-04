//
//  ServiceModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 09.02.2023.
//
import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
    
    var title: String {
        switch self {
        case .failedToCreateRequest:
           return "We got bad request, Please tray again later... 🙂"
        case .failedToGetData:
            return "We got bad data, Please tray again later... 🙂"
        }
    }
}
