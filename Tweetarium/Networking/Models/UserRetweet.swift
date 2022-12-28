//
//  UserRetweet.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct UserRetweet: Codable {
    let id: Int
    let idStr: String

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
    }
}
