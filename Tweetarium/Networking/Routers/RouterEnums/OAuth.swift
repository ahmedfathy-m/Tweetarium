//
//  OAuth.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

enum OAuth {
    // Router Constants
    var baseURL: String { return "https://api.twitter.com/oauth" }
    
    // Router Endpoints
    case requestToken(_ callback: String)
    case oauthToken(_ token: String)
    case accessToken
    case testRoute
}

extension OAuth: NetworkingRoute {
    var targetURL: String {
        switch self {
        case .requestToken: return "\(baseURL)/request_token"
        case .oauthToken: return "\(baseURL)/authorize"
        case .accessToken: return "\(baseURL)/access_token"
        case .testRoute: return "https://api.twitter.com/1.1/statuses/update.json"
        }
    }
    
    var defaultMethod: HTTPMethod {
        switch self {
        case .requestToken: return .post
        case .oauthToken: return .get
        case .accessToken: return .post
        case .testRoute: return .post
        }
    }
    
    var defaultBodyParameters: [String : String] {
        return [:]
    }
    
    var defaultQueryParameters: [String : String] {
        var parameters = [String: String]()
        switch self {
        case .requestToken:
            break
        case .oauthToken(let token):
            parameters["oauth_token"] = token
        case .accessToken:
            if let token = UserDefaults.standard.credentials?.token, let verifier = UserDefaults.standard.oauthVerifier {
                parameters["oauth_token"] = token
                parameters["oauth_verifier"] = verifier
            }
        case .testRoute:
            parameters["status"] = "Hello Ladies + Gentlemen, a signed OAuth request!"
            parameters["include_entities"] = "true"
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
