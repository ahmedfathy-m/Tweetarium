//
//  Coordinates.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct Coordinates: Codable {
    let coordinates: [Double]
    let type: String
}

struct PlaceObject: Codable {
    let attributes: Attributes
    let boundingBox: BoundingBox
    let country, countryCode, fullName, id: String
    let name, placeType: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case attributes
        case boundingBox = "bounding_box"
        case country
        case countryCode = "country_code"
        case fullName = "full_name"
        case id, name
        case placeType = "place_type"
        case url
    }
}

struct Attributes: Codable {
}

struct BoundingBox: Codable {
    let coordinates: [[[Double]]]
    let type: String
}
