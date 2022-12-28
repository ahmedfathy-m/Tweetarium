//
//  Users.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import Foundation

enum Users {
    // Router Constants
    var baseURL: String { return "https://api.twitter.com/1.1" }
    
    // Router Endpoints
    case show(_ userID: Int)
}

extension Users: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .show: return "\(baseURL)/users/show.json"
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
        case .show(let id):
            return ["user_id":"\(id)"]
        }
    }
    
    var defaultHeaders: [String : String] {
        return [:]
    }
    
    var shouldSignRequest: Bool {
        return true
    }
}
