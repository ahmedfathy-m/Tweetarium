//
//  MatchingRule.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct MatchingRule: Codable {
    let tag: String
    let id: Double
    let idStr: String

    enum CodingKeys: String, CodingKey {
        case tag, id
        case idStr = "id_str"
    }
}
