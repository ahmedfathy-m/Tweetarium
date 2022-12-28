//
//  Main.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

enum Statuses {
    // Router Constants
    var baseURL: String { return "https://api.twitter.com/1.1" }
    
    // Router Endpoints
    case home
    case mentions
    case profile
}

extension Statuses: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .home: return "\(baseURL)/statuses/home_timeline.json"
        case .mentions: return "\(baseURL)/statuses/mentions_timeline.json"
        case .profile: return "\(baseURL)/statuses/user_timeline.json"
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
        case .home, .mentions, .profile: return [
                "tweet_mode" : "extended",
                "count" : "60"
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
