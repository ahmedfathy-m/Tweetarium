//
//  URLObject.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct URLObject: Codable {
    let indices: [Int]
    let url: String
    let displayURL: String
    let expandedURL: String

    enum CodingKeys: String, CodingKey {
        case indices, url
        case displayURL = "display_url"
        case expandedURL = "expanded_url"
    }
}
