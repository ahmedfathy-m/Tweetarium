//
//  CreateTweetType.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import Foundation

enum TweetPostType {
    case tweet
    case quote(_ id: Int64)
    case reply(_ id: Int64)
}
