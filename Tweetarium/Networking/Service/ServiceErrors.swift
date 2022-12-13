//
//  ServiceErrors.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

enum ServiceError: Error {
    case serverError(Int)
    case clientError(Int)
    case routeError
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .serverError(let code): return "Server Error CODE \(code)"
            case .clientError(let code): return "Client Error CODE \(code)"
            case .routeError: return "Couldn't Construct URL"
        }
    }
}
