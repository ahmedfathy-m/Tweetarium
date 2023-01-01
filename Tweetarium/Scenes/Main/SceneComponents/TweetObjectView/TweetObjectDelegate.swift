//
//  TweetObjectDelegate.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import Foundation

protocol TweetObjectDelegate: AnyObject {
    func didPressLike(at tweetID: Int64, isAlreadyLiked: Bool) async -> String?
    // Returns updated likes count in string format
    func didSelectImage(imageURL: URL?)
    // Handles presentation of fullscreen image
    func didPressRetweetStatus(at tweetID: Int64, isAlreadyRetweeted: Bool) async -> String?
    // Returns updated retweets count in string format
    func didPressQuoteRetweet(at tweetID: Int64)
    // Handles presentation of quote retweet screen
    func didPressReplyToTweet(to tweetID: Int64)
    // Handles presentation of reply tweet screen
}
