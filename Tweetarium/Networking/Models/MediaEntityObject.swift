//
//  MediaEntityObject.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct MediaObject: Codable {
    let displayURL: String
    let expandedURL: String
    let id: Double
    let idStr: String
    let indices: [Int]
    let mediaURL: String
    let mediaURLHTTPS: String
    let sizes: ImageSizeObjects
    let type: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case displayURL = "display_url"
        case expandedURL = "expanded_url"
        case id
        case idStr = "id_str"
        case indices
        case mediaURL = "media_url"
        case mediaURLHTTPS = "media_url_https"
        case sizes, type, url
    }
}

struct ImageSizeObjects: Codable {
    let thumb, large, medium, small: ImageSize
}

struct ImageSize: Codable {
    let h: Int
    let resize: String
    let w: Int
}
