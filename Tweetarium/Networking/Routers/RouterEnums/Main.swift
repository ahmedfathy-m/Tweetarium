//
//  Main.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

enum Main {
    // Router Constants
    var baseURL: String { return "https://api.twitter.com/1.1" }
    
    // Router Endpoints
    case home
}

extension Main: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .home: return "\(baseURL)/statuses/home_timeline.json"
        }
    }
    
    var defaultMethod: HTTPMethod {
        return .get
    }
    
    var defaultBodyParameters: [String : String] {
        return [:]
    }
    
    var defaultQueryParameters: [String : String] {
        switch self {
            case .home: return [
                "tweet_mode" : "extended"
            ]
        }
    }
    
    var defaultHeaders: [String : String] {
        return [:]
    }
    
    var shouldSignRequest: Bool {
        return true
    }
    
    
}
