//
//  NetworkingRouter.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

protocol NetworkingRoute {
    var targetURL: String {get}
    var defaultMethod: HTTPMethod {get}
    var defaultBodyParameters: [String: String] {get}
    var defaultQueryParameters: [String: String] {get}
    var defaultHeaders: [String: String] {get}
    var shouldSignRequest: Bool {get}
    
    func asURLRequest() throws -> URLRequest
}

extension NetworkingRoute {
    func asURLRequest() throws -> URLRequest {
        guard let targetURL = URL(string: self.targetURL) else {
            throw ServiceError.routeError
        }
        var request = URLRequest(url: targetURL)
        request.method = self.defaultMethod
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
//         Insert Body Parameters
        switch self.defaultMethod {
        case .post, .patch, .put: request.bodyParameters = self.defaultBodyParameters
        default: break
        }
        
        request.queryParameters = defaultQueryParameters
        
        if shouldSignRequest {
            let signer = OAuthRequestSigner(route: self, clientKey: APIKeys.key, clientSecret: APIKeys.secret, oauthToken: Defaults.accessToken.value as? String, oauthTokenSecret: Defaults.accessTokenSecret.value as? String)
            let header = signer.buildAuthHeader()
            request.addValue(header, forHTTPHeaderField: "Authorization")
        }
        
        print(#function)
        print(request.value(forHTTPHeaderField: "Authorization"))
        
        return request
    }
}
