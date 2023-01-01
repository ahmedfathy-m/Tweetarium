//
//  SharedDefaults.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

struct API {
    static fileprivate let baseURL = "https://api.twitter.com/1.1"
    
    static fileprivate let favorites = "\(baseURL)/favorites"
    static fileprivate let statuses = "\(baseURL)/statuses"
    
    struct Favorites {
        static let create = "\(API.favorites)/create.json"
        static let destroy = "\(API.favorites)/destroy.json"
    }
    
    struct Statuses {
        static func retweet(_ id: Int) -> String { return "\(API.statuses)/retweet/\(id).json" }
        static func unretweet(_ id: Int) -> String { return "\(API.statuses)/unretweet/\(id).json" }
    }
}
