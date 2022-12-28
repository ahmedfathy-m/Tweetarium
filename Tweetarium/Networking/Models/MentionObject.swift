//
//  MentionObject.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct MentionObject: Codable {
    let name: String
    let indices: [Int]
    let screenName: String
    let id: Int
    let idStr: String

    enum CodingKeys: String, CodingKey {
        case name, indices
        case screenName = "screen_name"
        case id
        case idStr = "id_str"
    }
}

extension MentionObject {
    var range: NSRange {
        let length = indices[1] + 1 - indices[0]
        return NSRange(location: indices[0], length: length)
    }
}
