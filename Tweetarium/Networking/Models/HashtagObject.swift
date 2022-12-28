//
//  HashtagObject.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct HashtagObject: Codable {
    let indices: [Int]
    let text: String
}

extension HashtagObject {
    var range: NSRange {
        let length = indices[1] + 1 - indices[0]
        return NSRange(location: indices[0], length: length)
    }
}
