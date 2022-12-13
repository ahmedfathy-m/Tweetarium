//
//  URLRequest.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import Foundation

extension URLRequest {
    var method: HTTPMethod {
        get { return HTTPMethod(rawValue: self.httpMethod!)! }
        set { self.httpMethod = newValue.rawValue}
    }
    
    var bodyParameters: [String: Any] {
        get {
            let parameters = try? JSONSerialization.jsonObject(with: self.httpBody ?? Data()) as? [String : Any]
            return parameters ?? [:]
        }
        set {
            guard !newValue.isEmpty else { return }
            let jsonData = try? JSONSerialization.data(withJSONObject: newValue)
            self.httpBody = jsonData
        }
    }
    
    var queryParameters: [String: Any] {
        get {
            guard let url = self.url else { return [:] }
            let urlWithComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let queryItems = urlWithComponents?.queryItems
            var params = [String: String]()
            queryItems?.forEach { params[$0.name] = $0.value }
            return params
        }
        set {
            guard let url = self.url else { return }
            var urlWithComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let queryItems = newValue.map({URLQueryItem(name: $0.key, value: $0.value as? String)})
            urlWithComponents?.queryItems = queryItems
            self.url = urlWithComponents?.url
        }
    }
}
