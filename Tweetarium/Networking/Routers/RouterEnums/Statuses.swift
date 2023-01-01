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
    
    // Timelines
    case home
    case mentions
    case profile
    
    // Manage Status
    case create(text: String, inReplyToTweetID: Int64?)
    case show(id: Int64)
}

extension Statuses: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .home: return "\(baseURL)/statuses/home_timeline.json"
        case .mentions: return "\(baseURL)/statuses/mentions_timeline.json"
        case .profile: return "\(baseURL)/statuses/user_timeline.json"
        case .create: return "\(baseURL)/statuses/update.json"
        case .show: return "\(baseURL)/statuses/show.json"
        }
    }
    
    var defaultMethod: HTTPMethod {
        switch self {
        case .home, .mentions, .profile,.show: return .get
        case .create: return .post
        }
    }
    
    var defaultBodyParameters: [String : String] {
        return [:]
    }
    
    var defaultQueryParameters: [String : String] {
        var parameters = [String: String]()
        switch self {
        case .home, .mentions, .profile:
            parameters["tweet_mode"] = "extended"
            parameters["count"] = "60"
        case .create(let text, let statusID):
            parameters["status"] = text
            if let statusID = statusID {
                parameters["in_reply_to_status_id"] = "\(statusID)"
            }
        case .show(let id):
            parameters["id"] = "\(id)"
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
