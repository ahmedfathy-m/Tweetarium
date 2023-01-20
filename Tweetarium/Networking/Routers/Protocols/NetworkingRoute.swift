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
        request.contentType = .formURLEncoded
        
//         Insert Body Parameters
        switch self.defaultMethod {
        case .post, .patch, .put:
            request.bodyParameters = self.defaultBodyParameters
        default:
            break
        }
        
        request.queryParameters = defaultQueryParameters
        
        if shouldSignRequest {
            let signer = OAuthRequestSigner(route: self, client: Client.shared, credentials: UserDefaults.standard.credentials)
            signer.sign(request: &request)
        }
        
        return request
    }
}
