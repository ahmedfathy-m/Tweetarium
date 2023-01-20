//
//  URLRequestContentType.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 20/01/2023.
//

import Foundation

extension URLRequest {
    enum ContentType: String {
        case formURLEncoded = "application/x-www-form-urlencoded"
        case formData = "form-data"
        case raw
        case binary
        case GraphQL
    }
    
    var contentType: ContentType? {
        get {
            guard let type = value(forHTTPHeaderField: "Content-Type") else { return nil }
            return ContentType(rawValue: type)
        }
        set {
            guard let type = newValue?.rawValue else { return }
            addValue(type, forHTTPHeaderField: "Content-Type" )
        }
    }
}
