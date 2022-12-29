//
//  Actions.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 29/12/2022.
//

import Foundation

enum Actions {
    // Router Constants
    var baseURL: String { return "https://api.twitter.com/1.1" }
    
    // Router Endpoints
    case like(id: Int)
    case unlike(id: Int)
    case retweet(id: Int)
    case unretweet(id: Int)
}

extension Actions: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .like: return API.Favorites.create
        case .unlike: return API.Favorites.destroy
        case .retweet(let id): return API.Statuses.retweet(id)
        case .unretweet(let id): return API.Statuses.unretweet(id)
        }
    }
    
    var defaultMethod: HTTPMethod {
        return .post
    }
    
    var defaultBodyParameters: [String : String] {
        return [:]
    }
    
    var defaultQueryParameters: [String : String] {
        var parameters = [String: String]()
        switch self {
        case .like(let id), .unlike(let id):
            parameters["id"] = "\(id)"
        case .retweet, .unretweet:
            break
        }
        return parameters
    }
    
    var defaultHeaders: [String : String] {
        return [:]
    }
    
    var shouldSignRequest: Bool {
        return true
    }
}
