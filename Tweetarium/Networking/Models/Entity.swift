//
//  Entity.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct Entity: Codable {
    let hashtags: [HashtagObject]?
    let media: [MediaObject]?
    let urls: [URLObject]?
    let mentions: [MentionObject]?
    let symbols: [SymbolObject]?
    let polls: [PollObject]?
}
